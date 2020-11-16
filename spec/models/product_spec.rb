require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    
    # validates :name, presence: true
    # validates :price, presence: true
    # validates :quantity, presence: true
    # validates :category, presence: true 

    before(:each) do
      @category= Category.new
    end

    it 'saves if all fields are valide' do
      @product = Product.new(name: "Rocking Chair", price: 120, quantity: 12, category: @category)
      expect(@product).to be_valid
    end
    
    it 'validates the name is present' do
      @product = Product.new(name: nil, price: 120, quantity: 12, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates the price is present' do
      @product = Product.new(name: "Rocking Chair", price: nil, quantity: 12, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates the quantity is present' do
      @product = Product.new(name: "Rocking Chair", price: 120, quantity: nil, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates the category is present' do
      @product = Product.new(name: "Rocking Chair", price: 120, quantity: 12, category: nil)
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end  
  end
end
