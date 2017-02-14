class SourceFile < ApplicationRecord
  has_many  :affected_hosts, dependent: :destroy

end
