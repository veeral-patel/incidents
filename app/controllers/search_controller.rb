class SearchController < ApplicationController
    def index
        if params["q"]
            @results = PgSearch.multisearch(params["q"]).with_pg_search_highlight
            @results = @results.paginate(:page => params[:page], :per_page => 10)
        else
            @results = []
        end
    end
end