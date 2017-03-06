class SourceFile < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many  :affected_hosts, dependent: :destroy
  has_many :monitored_items, dependent: :destroy
  has_many :project_groups, through: :monitored_items
end
