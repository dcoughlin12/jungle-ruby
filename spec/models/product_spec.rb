require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should create a new product all valid fields" do
        @category = Category.new name: 'shirt' 
        @category.save
        @product = Product.new name: 'T shirt', category: @category, price: 500, quantity: 10 
        @product.save 
        expect(@product).to be_present
    end
    it "throws proper error when name is nil" do
      @category = Category.new name: 'shirt' 
      @category.save
      @product = Product.new name: nil, category: @category, price: 500, quantity: 10 
      @product.save 
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "throws proper error when category is nil" do
      @product = Product.new name: "T shirt", category: nil, price: 500, quantity: 10 
      @product.save 
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it "throws proper error when price is nil" do
      @category = Category.new name: 'shirt' 
      @category.save
      @product = Product.new name: "T shirt", category: @category, price: nil, quantity: 10 
      @product.save 
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "throws proper error when quantity is nil" do
      @category = Category.new name: 'shirt' 
      @category.save
      @product = Product.new name: "T shirt", category: @category, price: 500, quantity: nil
      @product.save 
      expect(@product.errors.full_messages).to include("Quantity can't be blank")

    end
  end
end

