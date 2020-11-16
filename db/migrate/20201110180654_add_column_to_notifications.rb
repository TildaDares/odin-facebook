class AddColumnToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :sender_id, :integer
  end
end
