# frozen_string_literal: true

class Activity < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :measurements, dependent: :destroy
end
