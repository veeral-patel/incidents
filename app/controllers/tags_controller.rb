class TagsController < ApplicationController
    def index
        @all_tags = ActsAsTaggableOn::Tag.all
        respond_to do |format|
            format.json { render json: @all_tags }
        end
    end
end
