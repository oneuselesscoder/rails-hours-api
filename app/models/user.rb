class User < ApplicationRecord
  has_many :hours, dependent: :destroy

  validates_presence_of :user_name

  def available?(start_time, end_time)
    hours.any?
  end
end
