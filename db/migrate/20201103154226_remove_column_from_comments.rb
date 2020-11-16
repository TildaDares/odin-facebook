class RemoveColumnFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :comment, :string
  end
end
