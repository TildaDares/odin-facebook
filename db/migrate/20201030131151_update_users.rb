class UpdateUsers < ActiveRecord::Migration[6.0]
  def change
    add_column("users", "provider", :string, :limit => 50, :null => false, :default => '')
    add_column("users", "uid", :string, :limit => 500, :null => false, :default => '')
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
