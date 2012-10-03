Totoslg::UnitType.define( :Actoon,
                          name: "Actoon",
                          details: "help",
                          power: 2,
                          toughness: 2,
                          attack_range_script: <<ATTACK_RANGE,
3 3 3 3 3 3 3
3 3 3 3 3 3 3
3 3 2 1 2 3 3
3 3 1 @ 1 3 3
3 3 2 1 2 3 3
3 3 3 3 3 3 3
3 3 3 3 3 3 3
ATTACK_RANGE
                          movement_script: <<MOVEMENT )
2 2 2 2 2 2 2
2 2 2 2 2 2 2
2 2 2 1 2 2 2
2 2 1 @ 1 2 2
2 2 2 1 2 2 2
2 2 2 2 2 2 2
2 2 2 2 2 2 2
MOVEMENT
