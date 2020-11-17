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

  scenario "They click on a product's details link" do
    # ACT
    visit root_path
    first(:link, 'Details').click
    # DEBUG / VERIFY
    sleep(1)
    save_screenshot('products_details.png')

    expect(page).to have_text 'Name', count: 1
    expect(page).to have_text 'Description', count: 1
    expect(page).to have_text 'Quantity', count: 1
    expect(page).to have_text 'Price', count: 1
    expect(page).to have_css '.products-show', count: 1
  end
end
