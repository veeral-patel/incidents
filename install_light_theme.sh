#!/bin/bash

bulma_dark="app/assets/stylesheets/bulma_dark.min.css"
dark_css="app/assets/stylesheets/dark_theme.scss"

# remove dark CSS files
[ -f $bulma_dark ] && rm $bulma_dark
[ -f $dark_css ] && rm $dark_css

bulma_light="app/assets/bulma/bulma_light.min.css"

# and add light Bulma
cp $bulma_light app/assets/stylesheets
