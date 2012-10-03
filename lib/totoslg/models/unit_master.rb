require "active_record"

class Totoslg::Models::UnitMaster < ActiveRecord::Base

  include Totoslg::MasterData
  include Totoslg::Models::StageMaster::Direction

  has_one :stage_master, through: :"player_master"
  belongs_to :player_master, class_name: "Totoslg::Models::PlayerMaster"
  belongs_to :character, class_name: "Totoslg::Models::Character"
  has_one :unit_type, through: :"character"

  def new
    unit = Totoslg::Models::Unit.new
    unit.master = self
    unit.x = self.x
    unit.y = self.y
    unit.direction = self.direction
    unit.damage = 0
    unit.untap = true
    unit
  end

  def as_string
    character.as_string
  end

  def _create_character_source character
    [:character, Totoslg::Character[character]]
  end

  def _create_x x
    [:x, x]
  end

  def _create_y y
    [:y, y]
  end

  def _create_direction direction
    [:direction, direction]
  end
end
