class AddTimestampsToPhones < ActiveRecord::Migration
  def up
    change_table :phones do |t|
      t.timestamps
    end
    Phone.all.each do |phone|
      phone.touch
    end
  end

  def down
    remove_column :phones, :created_at
    remove_column :phones, :updated_at
  end
end
