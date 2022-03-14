require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User validations" do 
    it "is valid when all fields are present" do
      @user = User.new(name: "Neale Taylor", email: "neale@taylor.com", password: "neale", password_confirmation: "neale")
      @user.save!
      expect(@user).to be_valid
    end

    it "is not valid when name is not present" do
      @user = User.new(name: nil, email: "neale@taylor.com", password: "neale", password_confirmation: "neale")
      expect(@user).to_not be_valid
    end

    it "is not valid when email is not present" do
      @user = User.new(name: "neale", email: nil, password: "neale", password_confirmation: "neale")
      expect(@user).to_not be_valid
    end

    it "is not valid when password is not present" do
      @user = User.new(name: "neale", email: "neale@taylor.com", password: nil, password_confirmation: "neale")
      expect(@user).to_not be_valid
    end

    it "is not valid when password confirmation is not present" do
      @user = User.new(name: "neale", email: "neale@taylor.com", password: "neale", password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it "is not valid when passwords do not match" do
      @user = User.new(name: "neale", email: "neale@taylor.com", password: "neale", password_confirmation: "beale")
      expect(@user).to_not be_valid
    end

    it "is not valid when passwords is too short" do
      @user = User.new(name: "neale", email: "neale@taylor.com", password: "hi", password_confirmation: "hi")
      expect(@user).to_not be_valid
    end

    it "is not valid when email already exists" do
      @user1 = User.create(name: "neale", email: "neale@taylor.com", password: "neale", password_confirmation: "neale")
      @user2 = User.new(name: "beale", email: "neale@taylor.com", password: "beale", password_confirmation: "beale")
      expect(@user2).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do 
    it "is valid when email matches but is in a different case" do 
      @user = User.create(name: "neale", email: "neale@taylor.com", password: "neale", password_confirmation: "neale")
      @auth = User.authenticate_with_credentials("NEALE@TAYLOR.COM", "neale")
      expect(@auth).to_not be_nil
      expect(@user.id).to match(@auth.id)
    end

    it "is valid when email has spaces around it" do 
      @user = User.create(name: "neale", email: "      neale@taylor.com  ", password: "neale", password_confirmation: "neale")
      @auth = User.authenticate_with_credentials("  neale@taylor.com  ", "neale")
      expect(@auth).to_not be_nil
      expect(@user.id).to match(@auth.id)
    end
  end
end
