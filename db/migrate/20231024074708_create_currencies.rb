class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :char_code
      t.integer :nominal
      t.decimal :value
      t.date :date

      t.timestamps
    end
    add_index :currencies, :date
    add_index :currencies, :char_code
  end
end
