class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @articles = []
    else
      @articles = []
      Article.search(params[:q]).each do |result|
        if user_signed_in?
          @articles.push result
        else
          @articles.push result if result.common?
        end
      end
    end
  end
end
