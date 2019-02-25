require 'rails_helper'

RSpec.describe User, type: :model do

  # create valid user before each test
  before(:each) do
    @user = User.new({
      first_name: 'Mike',
      last_name: 'Snow',
      email: 'Mikesnow444@gmail.com',
      password: '12345678',
      password_confirmation: '12345678'
    }) 
    @user.save
  end

  describe "Validations" do

    it "should be valid with valid field inputs" do
      expect(@user).to be_valid
    end

    context "password validation" do

      it "should have error if password field is not included" do
        @user.password = nil
        @user.save
        
        expect(@user.errors.full_messages.first).to eql "Password can't be blank"
      end

      it "should have error if password confirmation field is not included" do
        @user.password_confirmation = nil
        @user.save

        expect(@user.errors.full_messages.first).to eql "Password confirmation can't be blank"
      end

      it "should have error if password and password confirmation don't match" do
        @user.password = 'something'
        @user.password_confirmation = 'different'
        @user.save

        expect(@user.errors.full_messages.first).to eql "Password confirmation doesn't match Password"
      end

      it "should have error if password is too short" do
        @user.password = '1234567'
        @user.password_confirmation = '1234567'
        @user.save

        expect(@user.errors.full_messages.first).to eql "Password is too short (minimum is 8 characters)"
      end

      it "should not have error if password is required length" do
        @user.password = '12345678'
        @user.password_confirmation = '12345678'
        @user.save

        expect(@user).to be_valid
      end

    end

    context "email confirmation" do

      it "should return error if email exists in database" do
        @user2 = User.new({
          first_name: 'Mike',
          last_name: 'Snow',
          email: 'mikesnow444@gmail.com',
          password: 'asdf',
          password_confirmation: 'asdf'
        })
        @user2.save

        expect(@user2.errors.full_messages.first).to eql "Email has already been taken"
      end

      it "should return error if email exists in database, case sensitive" do
        @user2 = User.new({
          first_name: 'Mike',
          last_name: 'Snow',
          email: 'MikESNOw444@gmail.com',
          password: '12345678',
          password_confirmation: '12345678'
        })
        @user2.save

        expect(@user2.errors.full_messages.first).to eql "Email has already been taken"
      end

    end

  end

  describe ".authenticate_with_credentials" do

    it "should retern nil if email is not in database" do
      @user = User.authenticate_with_credentials("not_in_database@example.com", "12345678")

      expect(@user).to eq(nil)
    end

    it "should retern nil if email is correct but password is not" do
      @user = User.authenticate_with_credentials("mikesnow444@gmail.com", "123456789")

      expect(@user).to eq(nil)
    end

    it "should return correct user if credentials are correct" do
      @valid_user = User.authenticate_with_credentials('Mikesnow444@gmail.com', '12345678')

      expect(@valid_user).to eq(@user)
    end

    it "should return correct user if credentials are correct but wrong case" do
      @valid_user = User.authenticate_with_credentials('MiKeSNow444@gmail.com', '12345678')

      expect(@valid_user).to eq(@user)
    end

    it "should return correct user if credentials are correct but has white spaces before or after email" do
      @valid_user = User.authenticate_with_credentials('   MiKeSNow444@gmail.com ', '12345678')

      expect(@valid_user).to eq(@user)
    end

  end
end
