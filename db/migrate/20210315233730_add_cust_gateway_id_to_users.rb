class AddCustGatewayIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cust_gateway_id, :string
  end
end
