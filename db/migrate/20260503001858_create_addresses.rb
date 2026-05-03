class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
