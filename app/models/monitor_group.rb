class MonitorGroup < ApplicationRecord
  belongs_to :group
  belongs_to :source_files
end
