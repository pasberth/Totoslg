require "active_record"

class Totoslg::Models::Player < ActiveRecord::Base

  belongs_to :stage, class_name: "Totoslg::Models::Stage"
  belongs_to :master, class_name: "Totoslg::Models::PlayerMaster"
  has_many :units, class_name: "Totoslg::Models::Unit"
  has_many :squares, class_name: "Totoslg::Models::Square"

  def ai_enumerate_shifting
  end

  def ai_enumerate_movement
    return enum_for(:ai_enumerate_movement) unless block_given?

    units.reload
    units.each do |u|
      next if not u.untap

      u.refresh_movement_points!
      x1, y1 = u.x, u.y
      x2, y2 = u.movement_points.map { |(x, y), score| [x, y] }.sample
      u.x = x2
      u.y = y2
      u.untap = false
      u.save!

      yield [x1, y1], [x2, y2]
    end
  end

  def ai_enumerate_combat
  end
end
