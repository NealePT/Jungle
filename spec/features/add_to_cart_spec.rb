require 'rails_helper'

RSpec.feature "Visitor clicks add to cart", type: :feature, js: true do

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

  scenario "They click 'Add to Cart' button on a product" do
    visit root_path

    within ".product", match: :first do 
      click_on "Add", :visible => false
    end

    # Uncomment to debug 
    # save_and_open_screenshot

    expect(page).to have_content "My Cart (1)"
  end
end
