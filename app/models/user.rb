class User < ApplicationRecord
  has_many :hours, dependent: :destroy

  validates_presence_of :user_name

  def unavailable?
    hours.where("? BETWEEN starts AND ends", Time.zone.now).any?
  end
end
