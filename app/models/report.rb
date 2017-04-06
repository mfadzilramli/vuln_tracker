class Report < ApplicationRecord
  belongs_to  :affected_host
  belongs_to  :project_group
end
