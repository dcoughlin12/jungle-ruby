require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should create a new user with all valid fields" do
       @user = User.new name: "Jones", email: "bob@email.com", password_digest: "bob123"
       @user.save 

       expect(@user).to be_present
    end

    it "should store user when passwords match" do
      @user = User.new(
        name:"bobby",
        email: "testing@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save

      expect(@user).to be_present
    end


  end
end
