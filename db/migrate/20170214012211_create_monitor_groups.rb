class CreateMonitorGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :monitor_groups do |t|
      t.references :group, foreign_key: true
      t.references :source_files, foreign_key: true

      t.timestamps
    end
  end
end
