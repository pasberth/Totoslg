require "active_record"

class Totoslg::Models::Character < ActiveRecord::Base

  include Totoslg::MasterData

  belongs_to :unit_type, class_name: "Totoslg::Models::UnitType"

  def _create_name name
    [:name, name]
  end

  def _create_details details
    [:details, details]
  end

  def _create_unit_type_source type
    [:unit_type, Totoslg::UnitType[type]]
  end
end
