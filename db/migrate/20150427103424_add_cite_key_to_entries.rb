class AddCiteKeyToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :cite_key, :string
  end
end
