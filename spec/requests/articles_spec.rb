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

    it 'paginates articles' do
      article1, article2, article3 = create_list(:article, 3)

      get '/articles', params: { page: { number: 2, size: 1} }
      
      expect(json_data.length).to eq(1)
      expect(json_data.first[:id]).to eq(article2.id.to_s)
    end

    it 'contains pagination links in response' do
      article1, article2, article3 = create_list(:article, 3)

      get '/articles', params: { page: { number: 2, size: 1} }

      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(
        :first, :prev, :next, :last, :self
      )
    end
  end

  describe '#show' do
    let(:article) { create :article }

    subject { get "/articles/#{article.id}" }

    before { subject }

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      expect(json_data[:id]).to eq(article.id.to_s)
      expect(json_data[:type]).to eq('article')
      expect(json_data[:attributes]).to eq(
        {
            title: article.title,
            content: article.content,
            slug: article.slug
        }
      )
    end
  end
end
