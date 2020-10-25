require 'rails_helper'

RSpec.describe Activity, type: :model do
  before { FactoryBot.build(:activity) }
  it { should have_many(:measurements).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:total) }
end
