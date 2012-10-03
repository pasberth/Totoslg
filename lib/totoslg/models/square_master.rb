require "active_record"

class Totoslg::Models::SquareMaster < ActiveRecord::Base

  include Totoslg::MasterData

  belongs_to :map, class_name: "Totoslg::Models::Map"
  belongs_to :square_type, class_name: "Totoslg::Models::SquareType"

  def new
    squ = Totoslg::Models::Square.new
    squ.master = self
    squ.x = self.x
    squ.y = self.y
    squ
  end

  def as_string
    square_type.as_string
  end

  def _create_square_type_source square_type
    [:square_type, Totoslg::SquareType[square_type]]
  end

  def _create_square_type square_type
    [:square_type, square_type]
  end

  def _create_x x
    [:x, x]
  end

  def _create_y y
    [:y, y]
  end
end
