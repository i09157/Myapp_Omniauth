class CreateOmniusers < ActiveRecord::Migration
  def change
    create_table :omniusers do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :image
      t.string :token

      t.timestamps
    end
  end
end
