class ProjectGroup < ApplicationRecord
  serialize :source_file_ids
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :monitored_items, dependent: :destroy
  has_many :source_files, through: :monitored_items
end
