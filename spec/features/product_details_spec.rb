require 'rails_helper'

RSpec.feature "Visitor navigates product page from home page", type: :feature, js: true do

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

  scenario "They see the product page after clicking on listing from home page" do
    # ACT
    visit root_path

    first(".product img").click
    sleep(1)
    # DEBUG
    save_screenshot "product_page.png"

    # VERIFY
    expect(page).to have_css '.products-show'
  end
  

end