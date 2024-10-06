class CreateVideos < ActiveRecord::Migration[7.2]
  def change
    create_table :videos, id: :uuid do |t|
      t.references :user, type: :uuid
      t.string :resource_url, null: false
      t.timestamps
    end
  end
end
