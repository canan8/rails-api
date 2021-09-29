require 'rails_helper'

RSpec.describe ArticlesController do
  describe '#index' do
    it 'returns a success response' do
      get '/articles'

      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      article = create :article
      get '/articles'

      expect(json_data.size).to eq(1)
      expect(json_data.first[:id]).to eq(article.id.to_s)
      expect(json_data.first[:type]).to eq('article')
      expect(json_data.first[:attributes]).to eq(
        title: article.title,
        content: article.content,
        slug: article.slug
      )
    end

    it 'returns articles in the proper order' do
      older_article = create(:article, created_at: 2.days.ago)
      recent_article = create(:article, created_at: 1.day.ago)

      get '/articles'

      expect(json_data.first[:id]).to eq(recent_article.id.to_s)
      expect(json_data.last[:id]).to eq(older_article.id.to_s)
    end
  end
end
