require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validations' do
    let(:article) { create(:article) }
    
    it 'validates title presence' do
      article.title = ''
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it 'validates content presence' do
      article.content = ''
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it 'validates slug presence' do
      article.slug = ''
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

    it 'validates slug uniqueness' do
      article1 = create(:article, slug: 'slug-test')
      expect(article1).to be_valid

      article2 = build(:article, slug: 'slug-test')
      expect(article2).not_to be_valid
    end
  end
end
