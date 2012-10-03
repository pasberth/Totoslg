class InitialCommitCreatePlayer < ActiveRecord::Migration

  def change
    create_table :players do |t|
      t.references :stage
      t.references :master
    end
  end
end
