class User < ApplicationRecord
  has_many :hours, dependent: :destroy

  validates_presence_of :user_name

  def unavailable?(start_time, end_time)
    hours.where("starts >= ? AND ends <= ?", DateTime.parse(start_time), DateTime.parse(end_time)).any?
  end
end
