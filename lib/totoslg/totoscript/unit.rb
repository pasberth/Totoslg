require 'totoslg/totoscript/parsers'

module Totoslg::TotoScript

  class Unit

    include Parsers

    def self.create id, script
      p Movement::Parser.parse(script)
    end
  end
end
