Totoslg::UnitType.define( :Roun,
                          name: "Roun",
                          details: "help",
                          power: 1,
                          toughness: 1,
                          attack_range_script: <<ATTACK_RANGE,
3 3 3 3 3 3 3
3 3 3 3 3 3 3
3 3 2 1 2 3 3
3 3 1 @ 1 3 3
3 3 3 4 3 3 3
3 3 3 3 3 3 3
3 3 3 3 3 3 3
ATTACK_RANGE
                          movement_script: <<MOVEMENT )
3 3 3 3 3 3 3
3 3 3 1 3 3 3
1 3 1 1 1 3 3
3 3 1 @ 1 3 3
3 3 3 3 3 3 3
3 3 3 3 3 3 3
3 3 3 3 3 3 3
MOVEMENT
