# -*- coding: utf-8 -*-
require 'paint'
require 'console_window'
require 'console_board'

module Totoslg 

  class Window::GameWindow < ConsoleWindow::Container

    include ConsoleWindow
    include ConsoleBoard

    class BoardItem < Struct.new(:unit, :square)

      attr_accessor :on_region_movement
      attr_accessor :on_region_attack_range

      def name
        self.unit ? self.unit.character.name : self.square.square_type.name
      end

      def details
        self.unit ? self.unit.character.details : self.square.square_type.details
      end

      def as_string
        a = self.unit ? (case self.unit.direction
                         when Totoslg::Stage::DIR_UP then '/\\'
                         when Totoslg::Stage::DIR_DOWN then '\\/'
                         when Totoslg::Stage::DIR_LEFT then '<]'
                         when Totoslg::Stage::DIR_RIGHT then '[>'
                         end) : self.square.as_string
        a = (self.unit && self.unit.untap) ? ("\e[1m#{a}\e[0m") : a
        a = self.unit ? (["\e[34m", "\e[31m"][self.unit.player.master.number] + a + "\e[0m") : a
        if on_region_attack_range && on_region_movement
          a = "\e[45m#{a}\e[0m"
        elsif on_region_movement
          a = "\e[44m#{a}\e[0m"
        elsif on_region_attack_range
          a = "\e[41m#{a}\e[0m"
        end

        a
      end
    end

    def initialize *args
      super

      @info = ConsoleWindow::Window.new(owner: self, width: 20, height: height - 1, x: width - 20, y: 0)
      @cmd_line = ConsoleWindow::Window.new(owner: self, width: width, height: 1, x: 0, y: height)
      @board = Board.new(owner: self, width: width - 20, height: height - 1, x: 0, y: 0)
      @view_mapinfo = true

      frames.on :main, &method(:main)
      frames.on :init, &method(:init)
      frames.on :play, &method(:play)
      frames.on :game_set, &method(:game_set)
      frames.on :system_command, &method(:system_command)
      frames.on :shifting_phase, &method(:shifting_phase)
      frames.on :movement_phase, &method(:movement_phase)
      frames.on :combat_phase, &method(:combat_phase)
      frames.on :ai_shifting_phase, &method(:ai_shifting_phase)
      frames.on :ai_movement_phase, &method(:ai_movement_phase)
      frames.on :ai_combat_phase, &method(:ai_combat_phase)

      @board.frames.override :select, &method(:select)

      components << @board << @cmd_line << @info
    end

    def main stage
      focus! :init, stage
      focus! :play
      unfocus!
    end

    def init stage
      @stage = stage

      @board.table.width, @board.table.height = stage.map.width, stage.map.height
      @board.table.each_row do |row|
        row.width = 2
      end
      @board.table.each_culumn do |cul|
        cul.height = 1
      end
        
      @stage.culumns.each_with_index do |a, y|
        a.each_with_index do |(squ, unit), x|
          @board.table[x, y] = BoardItem.new(unit, squ)
        end
      end

      unfocus! :init
    end

    def select origin, *args, &block
      x, y = @board.board_cursor.x, @board.board_cursor.y

      if @view_mapinfo and
          @select_curx != x or
          @select_cury != y
        @select_curx = x
        @select_cury = y
        item = @board.table[x, y]
        @info.position = [0, 0]
        @info.text = ''
        @info.text << "phase: " + ["\e[34m", "\e[31m"][@stage.active_player.master.number] + "#{@stage.phase}" + "\e[0m"
        @info.text << "<%s>" % item.square.square_type.name
        if item.unit
          @info.text << "\e[1m%s\e[0m" % [item.unit.character.name]
          @info.text << "%d, [%d/%d]" % [item.unit.unit_type.power,
                                         item.unit.unit_type.toughness - item.unit.damage, item.unit.unit_type.toughness]
        end

      end

      @view_mapinfo = true
      origin.call(*args, &block)
    end

    def system_command
      @view_mapinfo = false
      @info.text = <<-DOC
q: quit
s: save
DOC
      case @cmd_line.gets
      when /^q/ then unfocus!; return
      when /^s/ then
      end

      unfocus! :system_command
    end

    def shifting_phase player
      key, x, y = @board.focus!(:select, [' ', '/', ':'])

      case key
      when ':'
        focus! :system_command
      when '/'
        @view_mapinfo = false
        @info.text = <<-DOC
e: end the phase.
DOC
        case @cmd_line.gets
        when /^e/
          unfocus! :shifting_phase
          return
        end
      when ' '
        item = @board.table[x, y]
        unit = item.unit
        return unless unit

        if unit.player.id != player.id
          @view_mapinfo = false
          @info.text = Paint["It isn't your unit.", :black, :red]
          return
        end

        if not unit.untap
          @view_mapinfo = false
          @info.text = Paint["It is already moved.", :black, :red]
          return
        end

        origin_dir = unit.direction

        while true
          show_range x, y

          case @board.getc
          when Curses::Key::LEFT
            hide_range x, y
            unit.direction = Totoslg::Stage::DIR_LEFT
            @board.table.modified x, y
          when Curses::Key::RIGHT
            hide_range x, y
            unit.direction = Totoslg::Stage::DIR_RIGHT
            @board.table.modified x, y
          when Curses::Key::UP
            hide_range x, y
            unit.direction = Totoslg::Stage::DIR_UP 
            @board.table.modified x, y
          when Curses::Key::DOWN
            hide_range x, y
            unit.direction = Totoslg::Stage::DIR_DOWN
            @board.table.modified x, y
          when ' '
            hide_range x, y
            unit.untap = false
            unit.save
            @board.table.modified x, y
            break
          when 'z'
            hide_range x, y
            unit.direction = origin_dir
            unit.save
            @board.table.modified x, y
            break
          end
        end
      end
    end

    def movement_phase player

      key, x, y = @board.focus!(:select, [' ', '/', ':'])

      case key
      when ':'
        focus! :system_command
      when '/'
        case @cmd_line.gets
        when /^e/
          unfocus! :movement_phase
          return
        end
      when ' '
        item = @board.table[x, y]
        unit = item.unit
        return unless unit

        if unit.player.id != player.id
          @view_mapinfo = false
          @info.text = Paint["It isn't your unit.", :black, :red]
          return
        end

        if not unit.untap
          @view_mapinfo = false
          @info.text = Paint["It is already moved.", :black, :red]
          return
        end

        key, move_x, move_y = nil

        movement_points = unit.movement_points.map { |(x, y), score| [x, y] }
        show_range(x, y) do
          key, move_x, move_y = @board.focus!(:select, ["\n", ' ', 'z'])
        end

        case key
        when "\n", ' '
          if movement_points.include? [move_x, move_y] and @board.table[move_x, move_y].unit.nil?
            unit.x = move_x
            unit.y = move_y
            unit.untap = false
            unit.save
            @board.table[x, y] = BoardItem.new(nil, item.square)
            @board.table[move_x, move_y] = BoardItem.new(item.unit, @board.table[move_x, move_y].square)
            @stage.units.each &:refresh_movement_points!
          else
            @view_mapinfo = false
            @info.text = Paint["It can't move here.", :black, :red]
            return
          end
        when 'z'
          return
        end
      end
    end

    def combat_phase player
      key, x, y = @board.focus!(:select, [' ', '/', ':'])

      case key
      when ':'
        focus! :system_command
      when '/'
        case @cmd_line.gets
        when /^e/
          unfocus! :combat_phase
          return
        end
      when ' '
        item = @board.table[x, y]
        unit = item.unit
        return unless unit

        if unit.player.id != player.id
          @view_mapinfo = false
          @info.text = Paint["It isn't your unit.", :black, :red]
          return
        end

        if not unit.untap
          @view_mapinfo = false
          @info.text = Paint["It is already moved.", :black, :red]
          return
        end

        key, atk_x, atk_y = nil
        attack_range_points = unit.attack_range_points.map { |(x, y), score| [x, y] }

        show_range(x, y) do
          key, atk_x, atk_y = @board.focus!(:select, ["\n", ' ', 'z'])
        end

        return if key == 'z'

        if not attack_range_points.include? [atk_x, atk_y] or @board.table[atk_x, atk_y].unit.nil?
          @view_mapinfo = false
          @info.text = Paint["It can't attack here.", :black, :red]
          return
        end

        if @board.table[atk_x, atk_y].unit.player.id == player.id
          @view_mapinfo = false
          @info.text = Paint["It is your unit.", :black, :red]
          return
        end

        unit.untap = false
        unit.save!
        @board.table[atk_x, atk_y].unit.damage += unit.unit_type.power
        @board.table[atk_x, atk_y].unit.save!
        @board.table.modified(x, y)
        @board.table.modified(atk_x, atk_y)
        return
      end
    end

    def ai_shifting_phase player
      player.ai_enumerate_shifting do |(x, y), dir|
        @board.table[x, y].unit.reload
        @board.table.modified(x, y)
        Fiber.yield
      end

      unfocus! :ai_shifting_phase
    end

    def ai_movement_phase player
      player.ai_enumerate_movement do |(x1, y1), (x2, y2)|
        if [x1, y1] != [x2, y2]
          @board.table[x1, y1].unit.reload
          @board.table[x2, y2].unit = @board.table[x1, y1].unit
          @board.table[x1, y1].unit = nil
          @board.table.modified(x1, y1)
        end
        @board.table.modified(x2, y2)
        Fiber.yield
      end

      unfocus! :ai_movement_phase
    end

    def ai_combat_phase player
      player.ai_enumerate_combat do |(x1, y1), (x2, y2)|
        @board.table[x1, y1].unit.reload
        @board.table[x2, y2].unit.reload
        @board.table.modified(x1, y1)
        @board.table.modified(x2, y2)        
        Fiber.yield
      end
      unfocus! :ai_combat_phase
    end

    def play

      @stage.units.reload

      @stage.units.each do |u|
        if u.damage >= u.unit_type.toughness
          @board.table[u.x, u.y].unit = nil
          u.destroy
        else
          u.refresh_attack_range_points!
          u.refresh_movement_points!
          u.untap = true
          u.save!
          @board.table[u.x, u.y].unit = u
        end

        @board.table.modified(u.x, u.y)
      end

      if @stage.players.any? { |plr| plr.units.reload; plr.units.empty? }
        focus! :game_set
        @cmd_line..getc
        unfocus! :play
        return
      end

      @stage.players.each do |plr|

        @stage.active_player = plr
        @stage.save!
        @view_mapinfo = true

        @stage.phase = Totoslg::Models::Stage::Phase::SHIFTING_PHASE
        @stage.save!

        if plr.master.input_type == "user"
          focus! :shifting_phase, plr
        elsif plr.master.input_type == "ai"
          focus! :ai_shifting_phase, plr
        end
      end

      @stage.players.each do |plr|

        @stage.active_player = plr
        @stage.save!
        @view_mapinfo = true

        @stage.phase = Totoslg::Models::Stage::Phase::MOVEMENT_PHASE
        @stage.save!

        if plr.master.input_type == "user"
          focus! :movement_phase, plr
        elsif plr.master.input_type == "ai"
          focus! :ai_movement_phase, plr
        end
      end

      @stage.players.each do |plr|

        @stage.active_player = plr
        @stage.save!
        @view_mapinfo = true

        @stage.phase = Totoslg::Models::Stage::Phase::COMBAT_PHASE
        @stage.save!

        if plr.master.input_type == "user"
          focus! :combat_phase, plr
        elsif plr.master.input_type == "ai"
          focus! :ai_combat_phase, plr
        end
      end
    end

    def game_set
      @view_mapinfo = false
      plrs = @stage.players.sort_by { |plr| -plr.units.count }
      @info.text = <<-RESULT
#{["\e[34m", "\e[31m"][plrs.first.master.number]}Player #{plrs.first.master.number}\e[0m Win!
      RESULT

      
      unfocus! :game_set
    end

    def show_range x, y
      item = @board.table[x, y]
      unit = item.unit

      return unless unit

      movement_points = unit.movement_points.map { |(x, y), score| [x, y] }
      attack_range_points = unit.attack_range_points.map { |(x, y), score| [x, y] }

      movement_points.each do |x, y|
        @board.table[x, y] or next
        @board.table[x, y].on_region_movement = true
        @board.table.modified(x, y)
      end

      attack_range_points.each do |x, y|
        @board.table[x, y] or next
        @board.table[x, y].on_region_attack_range = true        
        @board.table.modified(x, y)
      end

      if block_given?
        yield
        hide_range(x, y)
      end
    end

    def hide_range x, y
      item = @board.table[x, y]
      unit = item.unit

      return unless unit

      movement_points = unit.movement_points.map { |(x, y), score| [x, y] }
      attack_range_points = unit.attack_range_points.map { |(x, y), score| [x, y] }

      (movement_points | attack_range_points).each do |x, y|
        @board.table[x, y] or next
        @board.table[x, y].on_region_movement = false
        @board.table[x, y].on_region_attack_range = false
        @board.table.modified(x, y)
      end
    end
  end
end
