class TagsController < ApplicationController
    def index
        # always responds with JSON, even if request type is HTML
        @all_tags = ActsAsTaggableOn::Tag.all
        render json: @all_tags
    end
end
