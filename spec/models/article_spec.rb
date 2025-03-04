require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }

  context 'タイトルが2文字以上、100文字以下で@から始まらず、本文が10文字以上で、タイトルと本文の合計が20文字以上の場合' do
    let!(:article) { build(:article, user: user) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context 'タイトルが1文字の場合' do
    let!(:article) { build(:article, user: user, title: Faker::Lorem.characters(number: 1)) }

    it 'バリデーションエラーが返る' do
      expect(article).not_to be_valid
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
    end
  end

  context 'タイトルが100文字の場合' do
    let!(:article) { build(:article, user: user, title: Faker::Lorem.characters(number: 100)) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context 'タイトルが101文字の場合' do
    let!(:article) { build(:article, user: user, title: Faker::Lorem.characters(number: 101)) }

    it 'バリデーションエラーが返る' do
      expect(article).not_to be_valid
      expect(article.errors.messages[:title][0]).to eq('は100文字以内で入力してください')
    end
  end


end
