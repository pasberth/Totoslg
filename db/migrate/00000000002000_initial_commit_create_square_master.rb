class InitialCommitCreateSquareMaster < ActiveRecord::Migration

  def change
    create_table :square_masters do |t|
      t.string     :identifier, unique: true
      t.references :map
      t.references :square_type
      t.integer    :x
      t.integer    :y
    end
  end
end
