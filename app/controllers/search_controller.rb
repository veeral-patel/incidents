class SearchController < ApplicationController
    def index
        if params["q"]
            @results = PgSearch.multisearch(params["q"]).with_pg_search_highlight
        else
            @results = []
        end
    end
end