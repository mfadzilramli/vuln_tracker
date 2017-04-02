class CreateReportFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :report_files do |t|
      t.binary  :data
      t.string  :filename
      t.string  :mime_type
      t.timestamps
    end
  end
end
