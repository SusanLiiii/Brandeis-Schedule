class AddPasswordDigestToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :password_digest, :string
  end
end
