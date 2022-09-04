# == Schema Information
#
# Table name: sentences
#
#  id         :bigint           not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Sentence < ApplicationRecord
  has_many :sentences_entities, dependent: :destroy
  has_many :entities, through: :sentences_entities, inverse_of: :sentences
  accepts_nested_attributes_for :entities, reject_if: :all_blank, allow_destroy: true
end
