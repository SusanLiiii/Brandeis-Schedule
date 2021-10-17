class AddPasswordDigestToOrganizers < ActiveRecord::Migration[6.1]
  def change
    add_column :organizers, :password_digest, :string
  end
end
