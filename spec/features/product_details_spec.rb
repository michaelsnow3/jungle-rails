require 'rails_helper'

RSpec.feature "Vister is redirected to home page", type: :feature, js: true do

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

  scenario "Visiter clicks on a product" do
    visit root_path

    #select a product
    product = all('article.product').first

    #click the image tag within that product
    within(product) {find('img').click}

    #check if redirected to product-show page
    expect(page).to have_css('section.products-show')
    save_screenshot
  end

end
