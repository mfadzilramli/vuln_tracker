class SourceFile < ApplicationRecord
  has_many  :affected_hosts, dependent: :destroy
  has_many :monitored_items, dependent: :destroy
  has_many :project_groups, through: :monitored_items
end
