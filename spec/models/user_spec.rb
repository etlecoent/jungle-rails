require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    
    describe 'Password' do
    
      it 'validates the password is present' do
      
        @user = User.new(first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: nil, password_confirmation: 'password2')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'validates the password_confirmation is present' do
      
        @user = User.new(first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: 'password1', password_confirmation: nil)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'validates password & password_confirmation matchs' do

        @user = User.new(first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: 'password1', password_confirmation: 'password2')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'validates the length of the password is >= 10' do
        @user = User.new(first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: 'password1', password_confirmation: 'password2')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 10 characters)")
      end

      describe "Email" do
        
        it "validates email is present" do
        
          @user = User.new(first_name: 'Etienne', last_name: 'LC', email: nil, password: 'password10', password_confirmation: 'password10')
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it "validates an email is unique & case sensitive" do 
          @user1 = User.new(first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: 'password10', password_confirmation: 'password10')
          @user1.save
          @user2 = User.new(first_name: 'Etienne', last_name: 'LC', email: 'TEST@TEST.com', password: 'password10', password_confirmation: 'password10')
          @user2.save
          expect(@user2.errors.full_messages).to include("Email has already been taken")
        end
      end

      describe 'First name & Last name' do
      
        it 'validates First name is present' do
          @user = User.new(first_name: nil, last_name: 'LC', email: 'test@test.com', password: 'password1', password_confirmation: 'password1')
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'validates Last name is present' do
          @user = User.new(first_name: 'Etienne', last_name: nil, email: 'test@test.com', password: 'password1', password_confirmation: 'password1')
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
      end
    end
  end

  describe '.authenticate_with_credentials' do
      
    it 'returns an instance of the user if successfully authenticated' do
      @user = User.new(first_name: 'Etienne', last_name: "LC", email: 'test@test.com', password: 'password10', password_confirmation: 'password10')
      @user.save
      @auth_user = User.authenticate_with_credentials("test@test.com", "password10")
      expect(@auth_user).to be_eql(@user)
    end

    it 'returns nil if not successfully authenticated' do
      @user = User.new(first_name: 'Etienne', last_name: "LC", email: 'test@test.com', password: 'password10', password_confirmation: 'password10')
      @user.save
      @not_auth_user = User.authenticate_with_credentials("test@test.com", "password20")
      expect(@not_auth_user).to be nil
    end

    it 'returns an instance of the user if successfully authenticated with wrong case' do
      @user = User.new(first_name: 'Etienne', last_name: "LC", email: 'test@test.com', password: 'password10', password_confirmation: 'password10')
      @user.save
      @auth_user = User.authenticate_with_credentials("tEsT@TeSt.CoM", "password10")
      expect(@auth_user).to be_eql(@user)
    end

    it 'returns an instance of the user if successfully authenticated with space after email' do
      @user = User.new(first_name: 'Etienne', last_name: "LC", email: 'test@test.com', password: 'password10', password_confirmation: 'password10')
      @user.save
      @auth_user = User.authenticate_with_credentials(" tEsT@TeSt.CoM ", "password10")
      expect(@auth_user).to be_eql(@user)
    end

  end
end