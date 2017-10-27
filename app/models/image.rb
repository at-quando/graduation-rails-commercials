# == Schema Information
#
# Table name: images
#
#  id          :integer          not null, primary key
#  image       :string(255)
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :property
end
