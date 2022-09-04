# == Schema Information
#
# Table name: entities
#
#  id         :bigint           not null, primary key
#  text       :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Entity < ApplicationRecord
  # override inheritance column to avoid clashes with type column
  self.inheritance_column = '_'
  has_many :sentences_entities, dependent: :destroy
  has_many :sentences, through: :sentences_entities
  validates :text, :type, presence: true
  before_save :strip_and_upcase_type

  private

  def strip_and_upcase_type
    self.type = type.strip.upcase
  end
end
