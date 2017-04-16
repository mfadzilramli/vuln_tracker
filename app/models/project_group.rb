class ProjectGroup < ApplicationRecord
  serialize :source_file_ids
  serialize :affected_host_ids

  has_many :monitored_items, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :source_files, through: :monitored_items
  has_many :affected_hosts, through: :reports
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
