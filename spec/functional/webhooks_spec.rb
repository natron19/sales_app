require "rails_helper"

RSpec.feature 'WebhooksTest' do
  describe 'charge created' do
    event = StripeMock.mock_webhook_event('charge.succeeded', id: 'abc123')
    product = Product.create(price: 100, name: 'foo')
    sale = Sale.create(stripe_id: 'abc123', amount: 100, email: 'foo@bar.com', product: product)
    post '/stripe-events', id: event.id

    expect(response.code).to eq("200")
    expect(StripeMailer.deliveries.length).to eq(2)
    expect(StripeWebhook.last.stripe_id).to eq("abc123")
  end
end
