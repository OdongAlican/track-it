# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Measurement, type: :model do
  it { should belong_to(:activity) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:date) }
end
