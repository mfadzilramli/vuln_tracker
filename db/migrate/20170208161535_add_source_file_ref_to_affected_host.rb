class AddSourceFileRefToAffectedHost < ActiveRecord::Migration[5.0]
  def change
    add_reference :affected_hosts, :source_file, foreign_key: true
  end
end
