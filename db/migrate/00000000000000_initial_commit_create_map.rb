class InitialCommitCreateMap < ActiveRecord::Migration

  def change
    create_table :maps do |t|
      t.string  :identifier, unique: true
      t.string  :name
      t.text    :details
      t.integer :width
      t.integer :height
    end
  end
end
