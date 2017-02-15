class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :project_groups do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
