class TagsController < ApplicationController
    def index
        # always responds with JSON, even if request type is HTML
        @tags = ActsAsTaggableOn::Tag.all
        render json: @tags
    end
end
