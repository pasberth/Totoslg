require "active_record"

class Totoslg::Models::Stage < ActiveRecord::Base

  has_one :map, through: :"master"
  belongs_to :master, class_name: "Totoslg::Models::StageMaster"
  belongs_to :active_player, class_name: "Totoslg::Models::Player"
  has_many :players, class_name: "Totoslg::Models::Player"
  has_many :units, through: :"players"
  has_many :squares, class_name: "Totoslg::Models::Square"

  module Phase
    
    SHIFTING_PHASE = :shifting
    MOVEMENT_PHASE = :movement
    COMBAT_PHASE = :combat
  end

  def culumns
    return Enumerator.new(self, :culumns) unless block_given?
    (squares + units).group_by(&:y).sort_by { |y, a| y }.
      map { |i, a| a.group_by(&:x).sort_by { |x, a| x  }.map { |x, a| a } }.
      each { |a| yield *a }
  end
end
