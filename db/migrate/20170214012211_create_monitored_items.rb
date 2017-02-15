class CreateMonitoredItems < ActiveRecord::Migration[5.0]
  def change
    create_table :monitored_items do |t|
      # t.references :project_group, foreign_key: true
      # t.references :source_file, foreign_key: true
      t.belongs_to :project_group, index: true
      t.belongs_to :source_file, index: true
      t.timestamps
    end
  end
end
