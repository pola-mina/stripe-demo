class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.integer  :user_id
      t.integer  :payment_type
      t.integer  :cim_payment_profile_id
      t.string   :card_type
      t.string   :card_last4
      t.string   :card_exp_month
      t.string   :card_exp_year
      t.text     :extra_billing_info
      t.string   :account_type
      t.string   :bank_name
      t.string   :currency_iso_code
      t.boolean  :store_for_later
      t.string   :encrypted_account_number
      t.string   :routing_number
      t.string   :encrypted_account_number_iv
      t.string   :branch_transit_number
      t.string   :institution_bank_number
      t.string   :bsb
      # t.index [user_id], name: :index_payment_methods_on_user_id, using: :btree  
      t.timestamps
    end
  end
end
