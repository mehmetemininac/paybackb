class AddUserIdToContactsTable < ActiveRecord::Migration
  def up
  	add_column :contacts, :user_id, :integer
  end
end
