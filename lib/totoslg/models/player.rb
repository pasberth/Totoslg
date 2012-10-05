# -*- coding: utf-8 -*-

require "active_record"

class Totoslg::Models::Player < ActiveRecord::Base

  belongs_to :stage, class_name: "Totoslg::Models::Stage"
  belongs_to :master, class_name: "Totoslg::Models::PlayerMaster"
  has_many :units, class_name: "Totoslg::Models::Unit"
  has_many :squares, class_name: "Totoslg::Models::Square"

  def ai_enumerate_shifting
    return enum_for(:ai_enumerate_shifting) unless block_given?

    units.reload
    units.each do |u|
      next if not u.untap

      u.refresh_movement_points!
      u.refresh_attack_range_points!

      # いちばん近い敵ユニットを探す
      enemy = stage.units.find(:all, conditions: ["not player_id = ?", self.id]).
        sort_by { |enemy| (u.x - enemy.x).abs + (u.y - enemy.y).abs }.first
            # 左方向
      dir = if enemy.x - u.x  < 0
              # 上方向
              if enemy.y - u.y < 0
                # 左上の方で、かつより左の方にいる場合
                if (u.x - enemy.x).abs > (u.y - enemy.y).abs
                  Totoslg::Stage::DIR_LEFT
                # 左上のほうで、より上の方
                else
                  Totoslg::Stage::DIR_UP
                end
              else
                if (u.x - enemy.x).abs > (u.y - enemy.y).abs
                  Totoslg::Stage::DIR_LEFT
                else
                  Totoslg::Stage::DIR_DOWN
                end
              end
              
            else
              # 上方向
              if enemy.y - u.y < 0
                if (u.x - enemy.x).abs > (u.y - enemy.y).abs
                  Totoslg::Stage::DIR_RIGHT
                  # 左上のほうで、より上の方
                else
                  Totoslg::Stage::DIR_UP
                end
              else
                if (u.x - enemy.x).abs > (u.y - enemy.y).abs
                  Totoslg::Stage::DIR_RIGHT
                else
                  Totoslg::Stage::DIR_DOWN
                end
              end
            end

      return if dir == u.direction
      u.untap = false
      u.direction = dir
      u.save!
      yield [u.x, u.y], dir
    end
  end

  def ai_enumerate_movement
    return enum_for(:ai_enumerate_movement) unless block_given?

    units.reload
    units.each do |u|
      next if not u.untap

      u.refresh_movement_points!
      x1, y1 = u.x, u.y
      # いちばん移動できる距離を選ぶ
      (x2, y2), score = u.movement_points.sort_by { |(x, y), score| (u.x - x).abs ** 2 + (u.y - y).abs ** 2 + score }.last
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
