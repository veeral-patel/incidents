class SearchController < ApplicationController
    def index
        if params["q"]
            @results = PgSearch.multisearch(params["q"])
        else
            @results = []
        end
    end
end