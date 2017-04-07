class AddRefReport < ActiveRecord::Migration[5.0]
  def change
    add_reference :reports, :project_group, foreign_key: true
    add_reference :reports, :affected_host, foreign_key: true
  end
end
