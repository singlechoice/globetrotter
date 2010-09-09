class CreateQuestMemberships < ActiveRecord::Migration
  def self.up
    create_table :quest_memberships do |t|
      t.integer :user_id
      t.integer :quest_id

      t.timestamps
    end
  end

  def self.down
    drop_table :quest_memberships
  end
end
