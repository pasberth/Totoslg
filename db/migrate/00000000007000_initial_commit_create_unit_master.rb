class InitialCommitCreateUnitMaster < ActiveRecord::Migration

  def change
    create_table :unit_masters do |t|
      t.string     :identifier, unique: true
      t.references :player_master
      t.references :character
      t.integer    :x
      t.integer    :y
      t.integer    :direction
      t.integer    :damage
      t.boolean    :untap
    end
  end
end
