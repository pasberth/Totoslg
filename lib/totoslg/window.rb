require 'console_window'
require 'console_board'

module Totoslg
 
  class Window < ConsoleWindow::Container

    include ConsoleWindow
    include ConsoleBoard

    require 'totoslg/window/game_window'

    def initialize *args
      super

      @start_window = create_sub(ConsoleBoard::Board, width, height, 0, 0)
      @game_window = create_sub(GameWindow, width, height, 0, 0)
      @start_window.table.row(0).width = width
      @start_window.table.width = 1
      @start_window.table.height = Totoslg::Stage.all.length
      @start_window.table[0, 0] = '*'

      frames.on :main do
        Totoslg::Stage.all.each_with_index do |stage, i|
          @start_window.table[0, i] = "%20s: %s" % [stage.name, stage.details]
        end
        key, x, y = @start_window.focus!(:select, [' '])
        @game_window.focus!(:main, Totoslg::Stage.all[y].new)
        unfocus!
      end

      components << @start_window << @game_window
    end
  end
end
