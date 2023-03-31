require 'rails_helper'

#  Validation specs
# It must be created with a password and password_confirmation fields
# These need to match so you should have an example for where they are not the same
# These are required when creating the model so you should also have an example for this
# Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
# Email, first name, and last name should also be required
# The password must have a minimum length when a user account is being created.


RSpec.describe User, type: :model do
  describe 'User Validations' do

    it "The user has everything" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivia", email: "testEmail@email.com")
      @user.save
      expect(@user).to be_valid
    end

    it "throws an error when the name is not present" do
      @user = User.new(name: nil, password: "Olivia", password_confirmation: "Olivia", email: "testEmail@email.com")
      @user.save
      # expect(@user.errors.full_messages).to include("Name can't be blank")
      expect(@user).to_not be_valid
    end

    it "throws an error when the password is not present" do
      @user = User.new(name: "Glenn", password: nil, password_confirmation: "Olivia", email: "testEmail@email.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user).to_be not_valid
    end

    it "throws an error when the password confirmation is not present" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: nil, email: "testEmail@email.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      # expect(@user).to_not be_valid
    end

    it "throws an error when the password confirmation is not the same as the password" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivias", email: "testEmail@email.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation must match password")
      # expect(@user).to_not be_valid
    end

    it "throws an error when there is no email" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivia", email: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Email cannot be blank")
    end

    it "throws an error if the email is already present in the database" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivias", email: "testEmail@email.com")
      @user2 = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivias", email: "testEmail@email.com")
      @user.save
      @user2.save
      expect(@user2).to_not be_valid
    end
    
    it "throws an error if the password doesn't reach a minimum length" do
      @user = User.new(name: "Glenn", password: "O", password_confirmation: "O", email: "testEmail@email.com")
      @user.save
      expect(@user).to_not be_valid
    end
  end
  # Edge cases
  # What if a visitor types in a few spaces before and/or after their email address? 
  # They should still be authenticated successfully. Therefore " example@domain.com " should be successfully used to fetch by using email "example@domain.com".
  # What if a visitor types in the wrong case for their email? They should still be authenticated successfully. 
  # Eg: a user with email eXample@domain.COM should be allowed login with the email EXAMPLe@DOMAIN.CoM.

  describe '.authenticate_with_credentials' do

    it "rejects form submission if there are spaces trailing the email" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivia", email: " testemail.com ")
      @user.save
      expect(user).to_be not_valid
    end

    it "strips spaces from email addresses" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivia", email: " testemail.com ")
      @user.save
      expect(@user.email).to eq("testemail.com")
    end

    it "should adjust case for email entry" do
      @user = User.new(name: "Glenn", password: "Olivia", password_confirmation: "Olivia", email: "TeStEmaiL.cOm")
      @user.save
      expect(@user.email).to eq("testemail.com")
    end

  end

end