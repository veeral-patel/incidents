class SearchController < ApplicationController
    def index
        if params[:q]
            query = params[:q]
            @results = PgSearch.multisearch(query)
        else
            @results = []
        end
    end
end