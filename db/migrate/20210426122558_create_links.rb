class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.text :url
      t.string :slug
      t.integer :clicked, default: 0
      t.string :active, default: true
      t.timestamps null: false
    end
  end
end
