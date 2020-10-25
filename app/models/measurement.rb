class Measurement < ApplicationRecord
  belongs_to :activity
  validates_presence_of :duration, :date
end
