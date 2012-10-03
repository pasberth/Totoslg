require "active_record"

class Totoslg::Models::StageMaster < ActiveRecord::Base

  module Direction
    DIR_UP = 1
    DIR_DOWN = 2
    DIR_LEFT = 3
    DIR_RIGHT = 4
  end

  include Direction
  include Totoslg::MasterData

  belongs_to :map, class_name: "Totoslg::Models::Map"
  has_many :player_masters, class_name: "Totoslg::Models::PlayerMaster"
  has_many :unit_masters, through: :"player_masters"
  has_many :square_masters, through: :"map"

  def new
    stage = Totoslg::Models::Stage.new
    stage.master = self
    stage.phase = Totoslg::Models::Stage::Phase::SHIFTING_PHASE

    player_masters.map(&:new).each do |p|
      p.stage = stage
      p.save!
    end

    square_masters.map(&:new).each do |squ|
      squ.stage = stage
      squ.save!
    end

    stage.save!
    stage
  end

  def _create_map_source map
    [:map, Totoslg::Map[map]]
  end

  def _create_name name
    [:name, name]
  end

  def _create_details details
    [:details, details]
  end

  def _create_players players
    players.each_with_index do |plr, i|
      Totoslg::Models::PlayerMaster.define(:"#{self.identifier}_#{i}", plr)
      plr_model = Totoslg::Models::PlayerMaster[:"#{self.identifier}_#{i}"]
      plr_model.number = i
      plr_model.stage_master = self
      plr_model.save
    end

    nil
  end
end
