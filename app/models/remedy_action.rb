class RemedyAction < ApplicationRecord
  belongs_to  :vulnerability
  validates_uniqueness_of :vulnerability_id
end
