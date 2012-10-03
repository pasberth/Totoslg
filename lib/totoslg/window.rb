require 'console_window'
require 'console_board'

module Totoslg
 
  class Window < ConsoleWindow::Container

    include ConsoleWindow
    include ConsoleBoard

    require 'totoslg/window/game_window'

    def initialize *args
      super

      @start_window = create_sub(ConsoleWindow::Window, width, height, 0, 0)
      @game_window = create_sub(GameWindow, width, height, 0, 0)

      frames.before :main do
        Totoslg::Stage.all.each_with_index do |stage, i|
          @start_window.text[i] = "%20s: %s" % [stage.name, stage.details]
        end
      end

      frames.after :main do
        @start_window.text = ''
      end

      frames.on :main do
        case getc
        when 27.chr # ESC
          unfocus!
        when ' '    # Space
          @game_window.focus!(:main, Totoslg::Stage.all.first.new)
          unfocus!
        end
      end

      components << @start_window << @game_window
    end
  end
end
