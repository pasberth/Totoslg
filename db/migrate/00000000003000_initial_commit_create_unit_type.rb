class InitialCommitCreateUnitType < ActiveRecord::Migration

  def change
    create_table :unit_types do |t|
      t.string  :identifier, unique: true
      t.string  :name
      t.text    :details
      t.integer :power
      t.integer :toughness
      t.text    :attack_range
      t.text    :movement
    end
  end
end
