# This migration comes from brb_foundation_engine (originally 20150513225506)
class CreateJoinTableBuyersUnits < ActiveRecord::Migration
  def change
    create_join_table :buyers, :units do |t|
      t.index [:buyer_id, :unit_id]
      t.index [:unit_id, :buyer_id]
    end
  end
end
