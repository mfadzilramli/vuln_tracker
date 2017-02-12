class AffectedHost < ApplicationRecord
  belongs_to  :source_file
  has_many    :vulnerabilities, dependent: :destroy

  validates :host_ip, presence: true
end
