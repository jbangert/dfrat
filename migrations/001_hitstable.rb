Sequel.migration do
  up do
    create_table(:hits) do
      String :frat, :null => false, :index => true
      String :device, :null => false, :index => true
      DateTime :date, :null=> false, :index => true
    end
  end
  down do
    drop_table(:hits)
  end
end
