class SearchController < ApplicationController
    def index
        # whenever I add a new searchable type, remember to add it to this hash
        @policy_map = {
            "Incident": IncidentPolicy,
            "Observable": ObservablePolicy,
            "Ticket": TicketPolicy,
            "Comment": CommentPolicy,
            "Attachment": AttachmentPolicy,
        }

        if params["q"]
            @query = params["q"]
            @results = PgSearch.multisearch(@query).with_pg_search_highlight

            # only list search results the user is authorized to view
            @results = @results.select { |result| @policy_map[result.searchable_type.to_sym].new(current_user, result.searchable).show? }

            @results = @results.paginate(:page => params[:page], :per_page => 10)
        else
            @results = []
        end
    end
end
