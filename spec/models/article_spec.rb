require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }

  context 'タイトルが2文字以上、100文字以下で@から始まらず、本文が10文字以上で、タイトルと本文の合計が20文字以上の場合' do
    let!(:article) { build(:article, user: user) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  describe 'タイトルのバリデーション' do
    context 'タイトルが未入力の場合' do
      let!(:article) { build(:article, user: user, title: '') }

      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:title][0]).to eq('を入力してください')
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

    context 'タイトルが@から始まる場合' do
      let!(:article) { build(:article, user: user, title: '@から始まる場合') }

      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:title][0]).to eq('は不正な値です')
      end
    end

    context 'タイトルが@から始まり、101文字以上の場合' do
      let!(:article) { build(:article, user: user, title: "@#{Faker::Lorem.characters(number: 100)}") }

      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:title][0]).to eq('は100文字以内で入力してください')
        expect(article.errors.messages[:title][1]).to eq('は不正な値です')
      end
    end
  end

  describe '本文のバリデーション' do
    context '本文が未入力の場合' do
      let!(:article) { build(:article, user: user, content: '') }

      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:content][0]).to eq('を入力してください')
      end
    end

    context '本文が10文字の場合' do
      let!(:article) { build(:article, user: user, content: Faker::Lorem.characters(number: 10)) }

      it '記事を保存できる' do
        expect(article).to be_valid
      end
    end

    context '本文が9文字の場合' do
      let!(:article) { build(:article, user: user, content: Faker::Lorem.characters(number: 9)) }

      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:content][0]).to eq('は10文字以上で入力してください')
      end
    end
  end

  describe 'タイトルと本文のバリデーション' do
    context 'タイトルが@から始まる101文字以上で、本文が9文字の場合' do
      let!(:article) { build(:article, user: user, title: "@#{Faker::Lorem.characters(number: 100)}", content: Faker::Lorem.characters(number: 9)) }

      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:title][0]).to eq('は100文字以内で入力してください')
        expect(article.errors.messages[:title][1]).to eq('は不正な値です')
        expect(article.errors.messages[:content][0]).to eq('は10文字以上で入力してください')
      end
    end

    context 'タイトルと本文が合わせて20文字の場合' do
      let!(:article) { build(:article, user: user, title: Faker::Lorem.characters(number: 5), content: Faker::Lorem.characters(number: 15)) }
      it '記事を保存できる' do
        expect(article).to be_valid
      end
    end

    context 'タイトルと本文が合わせて19文字の場合' do
      let!(:article) { build(:article, user: user, title: Faker::Lorem.characters(number: 5), content: Faker::Lorem.characters(number: 14)) }
      it 'バリデーションエラーが返る' do
        expect(article).not_to be_valid
        expect(article.errors.messages[:content][0]).to eq('20文字以上の入力が必要です')
      end
    end
  end
end
