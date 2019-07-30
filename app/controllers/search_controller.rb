class SearchController < ApplicationController
    def index
        if params["q"]
            @results = PgSearch.multisearch(params["q"])
        else
            flash[:alert] = "Must specify a search string in the URL (for example, /search?q=hello)"
            @results = []
        end
    end
end