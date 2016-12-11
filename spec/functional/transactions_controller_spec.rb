require "rails_helper"
require 'stripe_mock'

describe MyApp do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  # it "creates a stripe customer" do

  #   # This doesn't touch stripe's servers nor the internet!
  #   # Specify :source in place of :card (with same value) to return customer with source data
  #   customer = Stripe::Customer.create({
  #     email: 'johnny@appleseed.com',
  #     card: stripe_helper.generate_card_token
  #   })
  #   expect(customer.email).to eq('johnny@appleseed.com')
  # end

  it "creates a product"
    product = Product.create(permalink: 'test_p', price: 100)

    email = 'pete@example.com'
    token = 'tok_test'

    post :create, email: email, stripeToken: token

    expect(:sale).to_exist
    expect((:sale).stripe_id).to_exist
    expect((:sale).product_id).to equal(product.id)
    expect((:sale).email).to equal(email)
  end

end
