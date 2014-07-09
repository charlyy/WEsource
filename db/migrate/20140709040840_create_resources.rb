class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.string :language
      t.string :link
      t.string :note
      t.references :user, index: true

      t.timestamps
    end
  end
end
