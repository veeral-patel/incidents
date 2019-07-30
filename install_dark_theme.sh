#!/bin/bash

bulma_light="app/assets/stylesheets/bulma_light.min.css"

# remove light Bulma
[ -f $bulma_light ] && rm $bulma_light

bulma_dark="app/assets/bulma/bulma_dark.min.css"
dark_css="app/assets/dark/dark_theme.scss"

# and add dark CSS files
cp $bulma_dark app/assets/stylesheets
cp $dark_css app/assets/stylesheets
