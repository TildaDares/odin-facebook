class AddColumnToSearches < ActiveRecord::Migration[6.0]
  def change
    add_reference :searches, :user, foreign_key: true
  end
end
