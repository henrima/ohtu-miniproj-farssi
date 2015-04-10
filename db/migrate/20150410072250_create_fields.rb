class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.text :content
      t.integer :entry_id

      t.timestamps null: false
    end
  end
end
