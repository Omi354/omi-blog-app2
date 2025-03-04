require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  before do
    post user_session_path, params: { user: { email: user.email, password: "password" } }
  end
  
  it "allows logged-in users to access their profile" do
    get edit_user_registration_path(user)
    expect(response).to have_http_status(200)
  end
end
