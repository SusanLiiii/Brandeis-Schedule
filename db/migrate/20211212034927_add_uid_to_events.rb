class AddUidToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :uid, :string
  end
end
