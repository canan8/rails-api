class ArticlesController < ApplicationController
  include Paginable

  def index
    paginated = paginate(Article.recent)

    render_collection(paginated)
  end

  def show
    article = Article.find(params[:id])

    render json: serializer.new(article)
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: ['User not found'] }, status: :not_found
  end

  def serializer
    ArticleSerializer
  end
end
