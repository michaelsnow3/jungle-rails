require 'rails_helper'

RSpec.feature "Adds item to cart when user clicks 'Add to cart' button", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: n,
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "user clicks a product's add to cart button on home page" do
    visit root_path

    # select a product on index page
    product = all('article.product').first

    # click add to cart button of selected product
    within(product) { find('button.add-to-cart').click }

    save_screenshot

    # expect link to cart to display cart with one item
    expect(find('a.my-cart')).to have_text 'My Cart (1)'
  end

end
