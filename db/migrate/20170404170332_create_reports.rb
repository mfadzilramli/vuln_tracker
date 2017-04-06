class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.belongs_to :project_group, index: true
      t.belongs_to :affected_host, index: true
      t.timestamps
    end
  end
end
