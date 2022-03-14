require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do 
    it 'is valid when all fields are present' do 
      @category = Category.new(name: "default")
      @product = Product.new(name: "product", price_cents: 1, quantity: 1, category: @category)
      expect(@product).to be_valid
    end

    it 'is not valid when name is not present' do 
      @category = Category.new(name: "default")
      @product = Product.create(name: nil, price_cents: 1, quantity: 1, category: @category)
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

    it 'is not valid when category is not present' do 
      @category = Category.new(name: "default")
      @product = Product.create(name: "product", price_cents: 1, quantity: 1, category: nil)
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end

    it 'is not valid when price is not present' do 
      @category = Category.new(name: "default")
      @product = Product.create(name: "product", price_cents: nil, quantity: 1, category: @category)
      expect(@product.errors.full_messages.first).to eq("Price cents is not a number")
    end

    it 'is not valid when quantity is not present' do 
      @category = Category.new(name: "default")
      @product = Product.create(name: "product", price_cents: 1, quantity: nil, category: @category)
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end
  end
end
