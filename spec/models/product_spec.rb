require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new({ name: 'electronics' })
      @product = @category.products.new({
        name: 'tv',
        price: 800,
        quantity: 12
      })
    end

    it "should be valid with presence of all valid fields" do
      expect(@product).to be_valid
    end

    it "should have an error if name is nil" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages.first).to eq "Name can't be blank"
    end

    it "should have an error if price is nil" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages.first).to eq "Price cents is not a number"
    end

    it "should have an error if quantity is nil" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages.first).to eq "Quantity can't be blank"
    end

    it "should have an error if category is nil" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages.first).to eq "Category can't be blank"
    end

  end
end
