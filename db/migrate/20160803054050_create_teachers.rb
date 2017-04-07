class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|

      t.string :name
      t.string :phase
      t.string :img_url

      t.timestamps null: false
    end
  end
end
