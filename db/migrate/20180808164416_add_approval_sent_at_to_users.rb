class AddApprovalSentAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :approval_sent_at, :datetime
  end
end
