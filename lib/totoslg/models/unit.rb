require "active_record"
require "game_pencil"

class Totoslg::Models::Unit < ActiveRecord::Base

  include Totoslg::Models::StageMaster::Direction

  has_one :stage, through: :"player"
  belongs_to :player, class_name: "Totoslg::Models::Player"
  belongs_to :master, class_name: "Totoslg::Models::UnitMaster"
  has_one :character, through: :"master"
  has_one :unit_type, through: :"master"
  

  def as_string
    character.as_string
  end

  def refresh_attack_range_points!
    @attack_range_points = nil
  end

  def refresh_movement_points!
    @movement_points = nil
  end

  def attack_range_points direction=self.direction
    @attack_range_points ||= {}
    @attack_range_points[direction] ||= each_attack_range_points(direction).to_a
  end

  def movement_points direction=self.direction
    @movement_points ||= {}
    @movement_points[direction] ||= each_movement_points(direction).to_a
  end

  def fix_point_with_direction x, y
    case direction
    when DIR_UP then [x, y]
    when DIR_DOWN then [(x - 6).abs, (y - 6).abs]
    when DIR_LEFT then [(y - 6).abs, x]
    when DIR_RIGHT then [y, (x - 6).abs]
    end
  end

  def each_attack_range_points direction=self.direction, &block
    return enum_for(:each_attack_range_points, direction) unless block_given?

    GamePencil::Pencil::ScoreMap.new do |x, y|
      next 0 if x == 3 and y == 3
      next if x < 0 or y < 0

      fixed_x, fixed_y = fix_point_with_direction(x, y)
      unit_type.attack_range[fixed_y] && unit_type.attack_range[fixed_y][fixed_x] or next
      unit_type.attack_range[fixed_y][fixed_x]
    end.
      begin(3, 3).
      movement([1, 0], [-1, 0], [0, 1], [0, -1]).
      limit_score(4).
      each do |root|
        root.each do |(x, y), score|
          yield [self.x + x - 3, self.y + y - 3], score
        end
    end
  end

  def each_movement_points direction=self.direction, &block
    return enum_for(:each_movement_points, direction) unless block_given?

    GamePencil::Pencil::ScoreMap.new do |x, y; fixed_x, fixed_y|
      next 0 if x == 3 and y == 3
      next if x < 0 or y < 0

      fixed_x, fixed_y = fix_point_with_direction(x, y)

      unit_type.movement[fixed_y] && unit_type.movement[fixed_y][fixed_x] or next
      stage.units.find(:first, conditions: { x: self.x + x - 3, y: self.y + y - 3 }) and next
      squ = stage.squares.find(:first, conditions: { x: self.x + x - 3, y: self.y + y - 3 }) or next
      unit_type.movement[fixed_y][fixed_x] + squ.square_type.cost - 1
    end.
      begin(3, 3).
      movement([1, 0], [-1, 0], [0, 1], [0, -1]).
      limit_score(4).
      each do |root|
        root.each do |(x, y), score|
          yield [self.x + x - 3, self.y + y - 3], score
        end
      end
  end
end
