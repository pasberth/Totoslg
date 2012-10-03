require "active_record"

class Totoslg::Models::Square < ActiveRecord::Base

  belongs_to :stage, class_name: "Totoslg::Models::Stage"
  belongs_to :master, class_name: "Totoslg::Models::SquareMaster"
  has_one :square_type, through: :"master"

  def as_string
    master.as_string
  end
end
