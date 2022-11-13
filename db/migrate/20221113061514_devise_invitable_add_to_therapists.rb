class DeviseInvitableAddToTherapists < ActiveRecord::Migration[6.1]
  def change
    add_column :therapists, :invitation_token, :string
    add_column :therapists, :invitation_created_at, :datetime
    add_column :therapists, :invitation_sent_at, :datetime
    add_column :therapists, :invitation_accepted_at, :datetime
    add_column :therapists, :invitation_limit, :integer
    add_column :therapists, :invited_by_id, :integer
    add_column :therapists, :invited_by_type, :string
    add_index :therapists, :invitation_token, unique: true
  end
end
