require 'rails_helper'

RSpec.describe Hour, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:starts) }
  it { should validate_presence_of(:ends) }
  it { should validate_presence_of(:valid_date) }
end
