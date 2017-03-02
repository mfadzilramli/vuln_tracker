class AffectedHost < ApplicationRecord
  belongs_to  :source_file
  has_many    :vulnerabilities, dependent: :destroy

  validates :host_ip, presence: true
  validates_uniqueness_of :host_ip, scope: [:source_file_id]
end
