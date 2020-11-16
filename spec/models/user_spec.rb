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

      describe "Email" do
        
        it "validates email is present" do
        
          @user = User.new(first_name: 'Etienne', last_name: 'LC', email: nil, password: 'password1', password_confirmation: 'password1')
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        xit "validates an email is unique & case sensitive" do 
          @user1 = User.new(first_name: 'Etienne', last_name: 'LC', email: 'test@test.com', password: 'password1', password_confirmation: 'password1')
          @user1.save
          @user2 = User.new(first_name: 'Etienne', last_name: 'LC', email: 'TEST@TEST.com', password: 'password1', password_confirmation: 'password1')
          @user2.save
          expect(@user2.errors.full_messages).to include("Email can't be blank")
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
end