require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    # create valid user before each test
    before(:each) do
      @user = User.new({
        first_name: 'Mike',
        last_name: 'Snow',
        email: 'mikesnow444@gmail.com',
        password: 'asdf',
        password_confirmation: 'asdf'
      }) 
      @user.save
    end

    it "should be valid with valid field inputs" do
      expect(@user).to be_valid
    end

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


  end
end
