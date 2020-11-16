class AddForeignKeyToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :user, foreign_key: true
  end
end
