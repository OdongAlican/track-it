class Activity < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :measurements, dependent: :destroy
  validates_presence_of :title, :total
end
