require "active_record"

class Totoslg::Models::Map < ActiveRecord::Base

  include Totoslg::MasterData

  has_many :square_masters

  def culumns
    return Enumerator.new(self, :culumns) unless block_given?
    square_masters.group_by(&:y).sort_by { |index, array| index }.each { |i, a| yield a }
  end

  def _create_name name
    [:name, name]
  end

  def _create_details details
    [:details, details]
  end

  def _create_script script
    map = _parse_script(script)
    self.width = map.first ? map.first.length : 0
    self.height = map.length    
    map.each_with_index do |cul, i|
      cul.each_with_index do |squ, j|
        squ_t = Totoslg::Models::SquareType.find_by_as_string(squ)
        Totoslg::Models::SquareMaster.define(:"#{self.identifier}_#{i}_#{j}", square_type: squ_t, x: j, y: i)
        squ_m = Totoslg::Models::SquareMaster[:"#{self.identifier}_#{i}_#{j}"]
        squ_m.map = self
        squ_m.save
      end
    end

    nil
  end
  
  def _parse_script script
    node = Totoslg::TotoScript::Parsers::Map.parse(script)
    map = node.select do |(stat_name, stat)|
      case stat_name
      when :comment then false
      when :map then true
      else fail
      end
    end.map do |(stat_name, *map)|
      map.map do |culumn|
        culumn.map do |cell|
          case cell[0]
          when :id then cell[1]
          else fail
          end
        end
      end
    end

    map.one? ? map.first : fail
  end
end
