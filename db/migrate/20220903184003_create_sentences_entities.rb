class CreateSentencesEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :sentences_entities do |t|
      t.references :sentences
      t.references :entities

      t.timestamps
    end
  end
end
