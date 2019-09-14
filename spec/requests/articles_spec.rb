require 'rails_helper'
RSpec.describe "Articles", type: :request do
  before :each do
    5.times do
      create(:article, category: category, user: user1)
    end
  end
  describe 'GET /articles' do
    let(:category) {create(:category, name: 'type A')}
    let(:user1) {create(:user, email: 'nikko@gmail.com', password: 'qwer4321')}
    let(:user2) {create(:user, email: 'nikko1@gmail.com', password: 'qwer4321')}
    it "should display articles" do
      get articles_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(Article.last.title)
    end
  end
  describe 'GET /articles' do
    let(:category) {create(:category, name: 'type A')}
    let(:user1) {create(:user, email: 'nikko@gmail.com', password: 'qwer4321')}
    let(:user2) {create(:user, email: 'nikko1@gmail.com', password: 'qwer4321')}
    it 'should display articles show page if login' do
      sign_in user1
      get article_path(Article.last.id)
      expect(response).to have_http_status(200)
    end
    it 'should not display if user is not logged in' do
      get article_path(Article.last.id)
      expect(response).to have_http_status(302)
      expect(response.location).to redirect_to(user_session_path)
    end
  end
  describe 'POST /articles' do
    let(:category) {create(:category, name: 'type A')}
    let(:user1) {create(:user, email: 'nikko@gmail.com', password: 'qwer4321')}
    it 'should create new articles if the user logged in' do
      sign_in user1
      article = {title: 'Nikko',content: 'sdsdsdsd',category_id: category.id}
      expect{
        post articles_path, params: {article: article}
      }.to change {Article.count}
      expect(response).to have_http_status(302)
      expect(Article.last.title).to eq(article[:title])
    end
  end
  describe 'GET /article' do
    let(:category) {create(:category, name: 'type A')}
    let(:user1) {create(:user, email: 'nikko@gmail.com', password: 'qwer4321')}
    it 'user redirect to articles path if user not logged in' do
      get article_path(Article.last)
      expect(response).to have_http_status(302)
    end
    it 'user redirect to articles edit path if user logged in' do
      sign_in user1
      get article_path(Article.last)
      expect(response).to have_http_status(200)
      expect(response.body).to include(Article.last.title)
    end
  end
  describe 'PATCH /article' do
    let(:category) {create(:category, name: 'type A')}
    let(:user1) {create(:user, email: 'nikko@gmail.com', password: 'qwer4321')}
    it 'should update article' do
      sign_in user1
      article = {title: 'nikko',content: 'dfghjsdfdfhu',category_id: category.id}
      patch article_path(Article.last.id), params: {article: article}
      expect(response).to have_http_status(302)
      expect(Article.last.title).to eq(article[:title])
      expect(Article.last.content).to eq(article[:content])
      expect(Article.last.category_id).to eq(article[:category_id])
    end
  end
  describe 'DELETE /article' do
    let(:category) {create(:category, name: 'type A')}
    let(:user1) {create(:user, email: 'nikko@gmail.com', password: 'qwer4321')}
    let(:user2) {create(:user, email: 'nikko1@gmail.com', password: 'qwer4321')}
    it 'should delete if article not belong to user' do
      sign_in user1
      article = Article.last
      delete article_path(article[:id])
      expect(response).to have_http_status(302)
      expect(Article.last.title).not_to eq(article[:title])
    end
    it 'should not delete if article not belong to user' do
      sign_in user2
      article = Article.last
      delete article_path(article[:id])
      expect(response).to have_http_status(302)
      expect(response.location).to redirect_to(articles_path)
    end
  end
end