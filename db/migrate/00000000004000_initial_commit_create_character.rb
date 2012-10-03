class InitialCommitCreateCharacter < ActiveRecord::Migration

  def change
    create_table :characters do |t|
      t.string     :identifier, unique: true
      t.references :unit_type
      t.string     :name
      t.text       :details
    end
  end
end
