require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They add a product to the cart and the cart increase by one" do
    # ACT
    visit root_path
    first(:button, 'Add').click

    # DEBUG / VERIFY
    sleep(1)
    save_screenshot('add_to_cart.png')

    expect(page.find_link(href:'/cart')).to have_text 'My Cart (1)'
  end
end