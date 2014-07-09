require 'spec_helper'

describe "Create payment on successful charge" do 
    let(:event_data) do 
      {
        "id"=> "evt_14EQww4NXe5wJuj75WUMIzMf",
        "created"=> 1404934914,
        "livemode"=> false,
        "type"=> "charge.succeeded",
        "data"=> {
          "object"=> {
            "id"=> "ch_14EQww4NXe5wJuj7yJO13CBp",
            "object"=> "charge",
            "created"=> 1404934914,
            "livemode"=> false,
            "paid"=> true,
            "amount"=> 999,
            "currency"=> "usd",
            "refunded"=> false,
            "card"=> {
              "id"=> "card_14EQwt4NXe5wJuj771ObrDLX",
              "object"=> "card",
              "last4"=> "4242",
              "brand"=> "Visa",
              "funding"=> "credit",
              "exp_month"=> 11,
              "exp_year"=> 2016,
              "fingerprint"=> "z2G9NMJPCN5ZFDry",
              "country"=> "US",
              "name"=> "meow@cats.com",
              "address_line1"=> nil,
              "address_line2"=> nil,
              "address_city"=> nil,
              "address_state"=> nil,
              "address_zip"=> nil,
              "address_country"=> nil,
              "cvc_check"=> "pass",
              "address_line1_check"=> nil,
              "address_zip_check"=> nil,
              "customer"=> "cus_4NBJLCIvob5eGN"
            },
            "captured"=> true,
            "refunds"=> {
              "object"=> "list",
              "total_count"=> 0,
              "has_more"=> false,
              "url"=> "/v1/charges/ch_14EQww4NXe5wJuj7yJO13CBp/refunds",
              "data"=> []
            },
            "balance_transaction"=> "txn_14EQww4NXe5wJuj7ofaFYVA3",
            "failure_message"=> nil,
            "failure_code"=> nil,
            "amount_refunded"=> 0,
            "customer"=> "cus_4NBJLCIvob5eGN",
            "invoice"=> "in_14EQww4NXe5wJuj7yFfxekaB",
            "description"=> nil,
            "dispute"=> nil,
            "metadata"=> {},
            "statement_description"=> nil,
            "receipt_email"=> nil
          }
        },
        "object"=> "event",
        "pending_webhooks"=> 3,
        "request"=> "iar_4NBJxcZY2NWFqw"
      }
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do 
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with the user" do
    alice = Fabricate(:user, customer_token: "cus_4NBJLCIvob5eGN")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount" do 
    alice = Fabricate(:user, customer_token: "cus_4NBJLCIvob5eGN")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id" do 
    alice = Fabricate(:user, customer_token: "cus_4NBJLCIvob5eGN")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_14EQww4NXe5wJuj7yJO13CBp")
  end
end






