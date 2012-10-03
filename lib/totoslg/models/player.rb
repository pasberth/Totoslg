require "active_record"

class Totoslg::Models::Player < ActiveRecord::Base

  belongs_to :stage, class_name: "Totoslg::Models::Stage"
  belongs_to :master, class_name: "Totoslg::Models::PlayerMaster"
  has_many :units, class_name: "Totoslg::Models::Unit"
  has_many :squares, class_name: "Totoslg::Models::Square"
end
