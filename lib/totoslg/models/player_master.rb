require "active_record"

class Totoslg::Models::PlayerMaster < ActiveRecord::Base

  include Totoslg::MasterData

  belongs_to :stage_master, class_name: "Totoslg::Models::StageMaster"
  has_many :unit_masters, class_name: "Totoslg::Models::UnitMaster"

  def new

    player = Totoslg::Models::Player.new
    player.master = self

    units = unit_masters.map &:new
    units.each do |unit|
      unit.player = player
      unit.save!
    end

    player.save!
    player
  end

  def _create_units units

    units.each_with_index do |unit, i|
      Totoslg::Models::UnitMaster.define(:"#{self.identifier}_#{i}", unit)
      unit_model = Totoslg::Models::UnitMaster[:"#{self.identifier}_#{i}"]
      unit_model.player_master = self
      unit_model.save
    end

    nil
  end
end
