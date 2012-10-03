class InitialCommitCreateUnit < ActiveRecord::Migration

  def change
    create_table :units do |t|
      t.references :player
      t.references :master
      t.integer    :x
      t.integer    :y
      t.integer    :direction
      t.integer    :damage
      t.boolean    :untap
    end
  end
end
