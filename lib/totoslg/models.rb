require 'active_record'

module Totoslg::Models

  require 'totoslg/models/unit_type'
  require 'totoslg/models/character'
  require 'totoslg/models/square_type'
  require 'totoslg/models/map'
  require 'totoslg/models/stage_master'
  require 'totoslg/models/player_master'
  require 'totoslg/models/unit_master'
  require 'totoslg/models/square_master'
  require 'totoslg/models/stage'
  require 'totoslg/models/player'
  require 'totoslg/models/unit'
  require 'totoslg/models/square'

  Totoslg::UnitType = UnitType
  Totoslg::Character = Character
  Totoslg::SquareType = SquareType
  Totoslg::Map = Map
  Totoslg::Stage = StageMaster
end
