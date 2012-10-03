require 'regparsec'

module Totoslg::TotoScript

  module Parsers

    module Lang

      extend RegParsec::Regparsers

      StatFeedComment = between("\n", ';', /[^;\n]*/) { |c| [:comment, c.to_s] }
      StatFeed = one_of(try(StatFeedComment), "\n")
      Comment = between('#', StatFeed, /.*/) { |c| [:comment, c.to_s] }
#      BeforeComment = try(between(/./, ';', /[^\n;]*/)) { |c| [:comment, c.to_s] }
      BlankLine = apply(/ */, StatFeed) { [:blank] }
    end

    module Range

      extend RegParsec::Regparsers
      include Lang

      Cost = apply(/\d+/) { |a| [:cost, a.join.to_i] }
      CenterMark = apply('@') { [:center, 0] }
      Square = apply(one_of(Cost, CenterMark), / */) { |a, b| a }
      Line = between(/ */, StatFeed, (many Square)) 
      Parser = many one_of(Comment, BlankLine, Line)

      class << self
        def parse script
          Parser.parse(script)
        end
      end
    end

    module Map

      extend RegParsec::Regparsers
      include Lang

      Identifier = apply(/\S+/) { |a| [:id, a.join] }
      Square = apply(Identifier, / */) { |a, b| a }
      Line = between(/ */, StatFeed, (many Square))
      Stat = many1(Line) { |r| [:map, *r] }
      Parser = many one_of(Comment, BlankLine, Stat)

      class << self
        def parse script
          Parser.parse(script)
        end
      end
    end
  end
end
