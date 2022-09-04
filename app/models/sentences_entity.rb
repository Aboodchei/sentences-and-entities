# == Schema Information
#
# Table name: sentences_entities
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  entity_id   :bigint
#  sentence_id :bigint
#
# Indexes
#
#  index_sentences_entities_on_entity_id    (entity_id)
#  index_sentences_entities_on_sentence_id  (sentence_id)
#
class SentencesEntity < ApplicationRecord
  belongs_to :sentence
  belongs_to :entity
end
