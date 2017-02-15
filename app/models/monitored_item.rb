class MonitoredItem < ApplicationRecord
  belongs_to :project_group
  belongs_to :source_file
end
