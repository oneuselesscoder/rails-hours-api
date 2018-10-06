class Hour < ApplicationRecord
  belongs_to :user

  validates_presence_of :starts, :ends
end
