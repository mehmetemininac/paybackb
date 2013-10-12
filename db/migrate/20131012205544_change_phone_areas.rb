class ChangePhoneAreas < ActiveRecord::Migration
  def change
  	change_column :contacts, :phone, :string, :limit => 15
  	change_column :contacts, :mobile, :string, :limit => 15
  end
end
