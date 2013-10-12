class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.string :name, :limit => 50
    	t.string :email, :limit => 60
    	t.string :phone, :limit => 10
    	t.string :mobile, :limit => 10
    	t.string :address, :limit => 255

      t.timestamps
    end
  end
end
