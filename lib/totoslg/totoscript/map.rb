require 'totoslg/totoscript/parsers'

module Totoslg::TotoScript

  class Map

    include Parsers

    def self.create id, script
      result = Map::Parser.parse(script) or raise ("parse error.")
      p result
    end
  end
end
