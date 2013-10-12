class CreateDepts < ActiveRecord::Migration
  def change
    create_table :depts do |t|

      t.timestamps
    end
  end
end
