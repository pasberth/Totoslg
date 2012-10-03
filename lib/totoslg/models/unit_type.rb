require "active_record"

class Totoslg::Models::UnitType < ActiveRecord::Base

  include Totoslg::MasterData

  serialize :attack_range, Array
  serialize :movement, Array


  def _create_name name
    [:name, name]
  end
  
  def _create_details details
    [:details, details]
  end
  
  def _create_power power
    [:power, power]
  end
  
  def _create_toughness toughness
    [:toughness, toughness]
  end
  
  def _create_attack_range_script script
    [:attack_range, _parse_range(script)]
  end
  
  def _create_movement_script script
    [:movement, _parse_range(script)]
  end
  
  def _parse_range script
    node = Totoslg::TotoScript::Parsers::Range.parse(script)
    node.map.with_index do |cul, y|
      cul.map.with_index do |(type, cost), x|
        case type
        when :cost then cost
        when :center then center = [x, y]; 0
        else fail
        end
      end
    end
  end
end
