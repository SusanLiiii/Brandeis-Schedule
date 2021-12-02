class AddIsCanceledToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :isCanceled, :boolean, default: false
  end
end
