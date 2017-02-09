class CreateSourceFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :source_files do |t|
      t.string  :title
      t.binary  :data
      t.string  :filename
      t.string  :mime_type

      t.timestamps
    end
  end
end
