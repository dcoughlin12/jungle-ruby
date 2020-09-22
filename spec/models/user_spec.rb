require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should create a new user with all valid fields" do
       @user = User.new name: "Jones", email: "bob@email.com", password: "bob123", password_confirmation: "bob123"
       @user.save 

       expect(@user).to be_valid
    end

    it "should store user when passwords match" do
      @user = User.new name:"bobby1", email: "testing1@test.com", password: "password", password_confirmation: "password123"
      @user.save

      # expect(@user).to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should NOT create a new user when email is taken, REGARDLESS OF CASE" do
      @user = User.new name: "Bob", email: "2@email.com", password: "bob123433333", password_confirmation: "bob123433333"
      @user.save
      @user1 = User.new name: "Bob", email: "2@EMAIL.com", password: "bob123433333", password_confirmation: "bob123433333"
      @user1.save

      expect(@user).to be_valid
      expect(@user1).to be_invalid
   end

   it "should NOT create a new user if pasword length < 6" do
    @user = User.new name: "Bob", email: nil, password: "1", password_confirmation: "1"
    @user.save
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    expect(@user).to be_invalid
   end

   it "should NOT create a new user if pasword no password is given" do
    @user = User.new name: "Bob", email: "2@email.com", password: "", password_confirmation: ""
    @user.save
    expect(@user.errors.full_messages).to include("Password can't be blank")
    expect(@user).to be_invalid
   end

   it "should NOT create a new user if email is blank" do
    @user = User.new name: "Bob", email: nil, password: "1", password_confirmation: "1"
    @user.save
    expect(@user.errors.full_messages).to include("Email can't be blank")
    expect(@user).to be_invalid
   end

  end

  describe '.authenticate_with_credentials' do
    it "should login with valid email and password" do
      @user = User.new name: "Bob", email: "2@email.com", password: "111111", password_confirmation: "111111"
      @user.save

      @session = User.authenticate_with_credentials("2@email.com", "111111")
      expect(@session).to be_truthy
    end

    it "should NOT login without valid email" do
      @user = User.new name: "Bob", email: "2@email.com", password: "111111", password_confirmation: "111111"
      @user.save

      @session = User.authenticate_with_credentials("nope@email.com", "111111")
      expect(@session).to be_falsey
    end

    it "should NOT login without valid password" do
      @user = User.new name: "Bob", email: "2@email.com", password: "111111", password_confirmation: "111111"
      @user.save

      @session = User.authenticate_with_credentials("2@email.com", "111defwref111")
      expect(@session).to be_falsey
    end

    it "should login without trailing spaces on email" do
      @user = User.new name: "Bob", email: "2@email.com", password: "111111", password_confirmation: "111111"
      @user.save

      @session = User.authenticate_with_credentials("   2@email.com   ", "111111")
      expect(@session).to be_truthy
    end

    it "should login without trailing spaces on email" do
      @user = User.new name: "Bob", email: "2@email.com", password: "111111", password_confirmation: "111111"
      @user.save

      @session = User.authenticate_with_credentials("2@EMAIL.com", "111111")
      expect(@session).to be_truthy
    end

  end

end
