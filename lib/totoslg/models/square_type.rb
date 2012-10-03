require 'paint'
require "active_record"

class Totoslg::Models::SquareType < ActiveRecord::Base

  include Totoslg::MasterData

  def as_string
    @as_string ||= Paint[super, as_string_color.to_sym]
  end

  def _create_name name
    [:name, name]
  end
  
  def _create_details details
    [:details, details]
  end

  def _create_as_string as_s
    [:as_string, as_s]
  end

  def _create_as_string_color as_sc
    [:as_string_color, as_sc]
  end

  def _create_cost cost
    [:cost, cost]
  end
end
