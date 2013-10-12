class AddTypeAreaToAccountingRecordsTable < ActiveRecord::Migration
  def up
  	add_column :accounting_records, :record_type, :string, :null => false, :limit => 10
  end
end
