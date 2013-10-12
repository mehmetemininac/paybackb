class CreateAccountingRecords < ActiveRecord::Migration
  def change
    create_table :accounting_records do |t|
    	#t.references :user
    	t.references :contact
    	t.integer :value
    	t.float :bank_rate
    	t.string :note, :limit => 500
    	t.boolean :is_active, :default => true
    	t.datetime :due_date
      t.timestamps
    end
  end
end
