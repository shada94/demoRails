class AddBalanceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :balance, :int, default: 20
  end
end
