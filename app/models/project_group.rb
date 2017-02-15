class ProjectGroup < ApplicationRecord
  serialize :source_file_ids

  has_many :monitored_items, dependent: :destroy
  has_many :source_files, through: :monitored_items
end
