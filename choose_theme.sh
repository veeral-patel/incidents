#!/bin/bash

print_usage() {
    echo ""
    echo "Usage:"
    echo "./choose_theme.sh dark"
    echo "./choose_theme.sh light"
}

# fail if user doesn't specify a theme
if [ $# -eq 0 ]; then
    echo "Error: Must specify the theme you'd like to switch to."
    print_usage
    exit
fi

dark_css_fresh="app/assets/dark/dark_theme.scss"
dark_css_existing="app/assets/stylesheets/dark_theme.scss"

bulma_light_fresh="app/assets/bulma/bulma_light.min.css"
bulma_light_existing="app/assets/stylesheets/bulma_light.min.css"

bulma_dark_fresh="app/assets/bulma/bulma_dark.min.css"
bulma_dark_existing="app/assets/stylesheets/bulma_dark.min.css"

# switch to light mode
if [ $1 == "light" ]; then
    # remove dark CSS files
    [ -f $bulma_dark_existing ] && rm $bulma_dark_existing
    [ -f $dark_css_existing ] && rm $dark_css_existing

    # and add light Bulma
    cp $bulma_light_fresh app/assets/stylesheets

    echo 'Switched to light theme'

# switch to dark mode
elif [ $1 == 'dark' ]; then
    # remove light Bulma
    [ -f $bulma_light_existing ] && rm $bulma_light_existing

    # and add dark CSS files
    cp $bulma_dark_fresh app/assets/stylesheets
    cp $dark_css_fresh app/assets/stylesheets

    echo 'Switched to dark theme'
else
    echo "Error: Theme must be either 'light' or 'dark'"
    print_usage
    exit
fi
