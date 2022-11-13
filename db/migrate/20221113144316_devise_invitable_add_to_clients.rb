class DeviseInvitableAddToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :invitation_token, :string
    add_column :clients, :invitation_created_at, :datetime
    add_column :clients, :invitation_sent_at, :datetime
    add_column :clients, :invitation_accepted_at, :datetime
    add_column :clients, :invitation_limit, :integer
    add_column :clients, :invited_by_id, :integer
    add_column :clients, :invited_by_type, :string
    add_index :clients, :invitation_token, unique: true
  end
end
