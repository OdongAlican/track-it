# frozen_string_literal: true

class Activity < ApplicationRecord
  has_many :measurements, dependent: :destroy
end
