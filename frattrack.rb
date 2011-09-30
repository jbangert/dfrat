#!/usr/bin/ruby
#TO INITIALIZE run sequel -m migrations/ sqlite://frat.db
require "rubygems"
require "bundler/setup"
require "sinatra"
require "date"
require "sequel"
require "digest/md5"
FRATS = ["axa","bg","signu"]
DBSTRING = "sqlite://frat.db"

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end
DB = Sequel.connect(DBSTRING)
post "/" do
  DB.transaction do
    client_id = Digest::MD5.hexdigest("ANON_request.ip.to_s")
    if( DB[:hits].where(:device => client_id).exists) # Should multiple entries for some reason exist, kill them all
      DB[:hits].where(:device=> client_id).delete
    end
    if(FRATS.include? params[:frat]) # You can delete your frat by just specifying an empty frat
      DB[:hits].insert(:frat => params[:frat], :device => client_id , :date => DateTime.now)
    end
  end
  redirect "/"
end
get "/" do
  @hits_by_frat =  Hash[ DB[:hits].group_and_count(:frat).map {|hash| # group_and_count gives you an array of hashes (DB rows) 
                        [ hash[:frat] , hash[:count] ]  # Convert them into one hash
                           }]
  FRATS.each do |frat|
    @hits_by_frat[frat] ||= 0 # Set all frats that do not have a hit to zero
  end    
  erb :page 
end
