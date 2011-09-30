#!/bin/sh
for frat in "ΑΔ ΑΦΑ ΑΧΑ ΒΑΩ BG ΓΔΧ ΘΔΧ ΚΚΚ ΛΥΛ ΣΑΕ ΣΝ ΣΦΕ ΦΔΑ ΧΓΕ ΧH ΨΥ"; do
   convert -size 50x40 canvas:none -font   Bookman-DemiItalic  -pointsize 36 \
       -draw "text 2, '$frat'" public/frat.png
done