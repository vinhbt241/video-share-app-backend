class CreateVideos < ActiveRecord::Migration[7.2]
  def change
    create_table :videos, id: :uuid do |t|
      t.references :user, type: :uuid
      t.string :resource_url, null: false
      t.string :embedded_id
      t.string :title
      t.string :description
      t.integer :likes
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
