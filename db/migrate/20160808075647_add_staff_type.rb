class AddStaffType < ActiveRecord::Migration
  def change
    add_column :teachers, :staff_type, :string
    add_column :mentors, :staff_type, :string
  end
end
