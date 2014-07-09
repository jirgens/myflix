require 'spec_helper'

describe 'Deactivate user on failed charge' do 
  let(:event_data) do 
    {
      "id" => "evt_14ESsc4NXe5wJuj7hV5WFDzK",
      "created" => 1404942334,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_14ESsc4NXe5wJuj7XQwuvUox",
          "object" => "charge",
          "created" => 1404942334,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_14ESs24NXe5wJuj7aElIxAdJ",
            "object" => "card",
            "last4" => "0341",
            "brand" => "Visa",
            "funding" => "credit",
            "exp_month" => 7,
            "exp_year" => 2015,
            "fingerprint" => "7fFMiKQEO2o1Qyhs",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "customer" => "cus_4NBqVHhEu0H0Lu"
          },
          "captured" => false,
          "refunds" => {
            "object" => "list",
            "total_count" => 0,
            "has_more" => false,
            "url" => "/v1/charges/ch_14ESsc4NXe5wJuj7XQwuvUox/refunds",
            "data" => []
          },
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded" => 0,
          "customer" => "cus_4NBqVHhEu0H0Lu",
          "invoice" => nil,
          "description" => "card to fail",
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => nil,
          "receipt_email" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4NDJeKFywawmrJ"
    }
  end
  
  it "deactivates a user with the webhook data from stripe for a charge failed" do 
    alice = Fabricate(:user, customer_token: "cus_4NBqVHhEu0H0Lu")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end

end