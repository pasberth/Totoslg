class InitialCommitCreatePlayerMaster < ActiveRecord::Migration

  def change
    create_table :player_masters do |t|
      t.string     :identifier, unique: true
      t.references :stage_master
      t.integer    :number
      t.string     :name
      t.text       :details
    end
  end
end
