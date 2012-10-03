class InitialCommitCreateStage < ActiveRecord::Migration

  def change
    create_table :stages do |t|
      t.references :master
      t.references :active_player
      t.string     :phase
    end
  end
end
