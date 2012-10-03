class InitialCommitCreateStageMaster < ActiveRecord::Migration

  def change
    create_table :stage_masters do |t|
      t.string     :identifier, unique: true
      t.references :map
      t.string     :name
      t.text       :details
    end
  end
end
