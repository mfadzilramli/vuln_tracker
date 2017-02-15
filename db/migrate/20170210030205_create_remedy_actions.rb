class CreateRemedyActions < ActiveRecord::Migration[5.0]
  def change
    create_table :remedy_actions do |t|
      t.integer   :status, default: 1
      t.string    :assigned_to
      t.text      :remarks

      t.timestamps
    end
    add_reference :remedy_actions, :vulnerability, foreign_key: true
  end
end
