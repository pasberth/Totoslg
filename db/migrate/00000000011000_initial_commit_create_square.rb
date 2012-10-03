class InitialCommitCreateSquare < ActiveRecord::Migration

  def change

    create_table :squares do |t|
      t.references :stage
      t.references :master
      t.integer    :x
      t.integer    :y
      t.timestamp
    end
  end
end
