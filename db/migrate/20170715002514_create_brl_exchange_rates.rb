class CreateBrlExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :brl_exchange_rates do |t|
      t.date :date
      t.float :value

      t.timestamps
    end
  end
end
