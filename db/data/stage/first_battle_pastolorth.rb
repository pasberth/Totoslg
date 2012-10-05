Totoslg::Stage.define( :FirstBattlePastolorth, 
                       map_source: :"FirstBattle",
                       name:       "First battle pastolorth",
                       details:    "test",
                       players: [ {
                                    input_type: "user",
                                    units: [ { character_source: :"Pastolorth",
                                               x: 2,
                                               y: 11,
                                               direction: Totoslg::Stage::DIR_UP },
                                             { character_source: :"BeanF",
                                               x: 3,
                                               y: 10,
                                               direction: Totoslg::Stage::DIR_UP },
                                             { character_source: :"BeanF",
                                               x: 1,
                                               y: 10,
                                               direction: Totoslg::Stage::DIR_UP },
                                             { character_source: :"BeanF",
                                               x: 0,
                                               y: 12,
                                               direction: Totoslg::Stage::DIR_UP },

                                             { character_source: :"Arbern",
                                               x: 3,
                                               y: 15,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 4,
                                               y: 14,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 2,
                                               y: 16,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 4,
                                               y: 16,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                           ]
                                  },
                                  {
                                    input_type: "ai",
                                    units: [
                                            # North troops.
                                            { character_source: :"Roun",
                                               x: 2,
                                               y: 2,
                                               direction: Totoslg::Stage::DIR_DOWN },
                                             { character_source: :"Roun",
                                               x: 3,
                                               y: 2,
                                               direction: Totoslg::Stage::DIR_DOWN },
                                             { character_source: :"Roun",
                                               x: 4,
                                               y: 3,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 5,
                                               y: 4,
                                               direction: Totoslg::Stage::DIR_LEFT },

                                             { character_source: :"Roun",
                                               x: 6,
                                               y: 1,
                                               direction: Totoslg::Stage::DIR_DOWN },
                                             { character_source: :"Roun",
                                               x: 7,
                                               y: 2,
                                               direction: Totoslg::Stage::DIR_DOWN },
                                             { character_source: :"Roun",
                                               x: 8,
                                               y: 3,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 8,
                                               y: 4,
                                               direction: Totoslg::Stage::DIR_LEFT },

                                             # South troops.
                                             { character_source: :"Roun",
                                               x: 14,
                                               y: 14,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 14,
                                               y: 15,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 14,
                                               y: 16,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 14,
                                               y: 17,
                                               direction: Totoslg::Stage::DIR_LEFT },

                                             { character_source: :"Roun",
                                               x: 16,
                                               y: 14,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 16,
                                               y: 15,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 16,
                                               y: 16,
                                               direction: Totoslg::Stage::DIR_LEFT },
                                             { character_source: :"Roun",
                                               x: 16,
                                               y: 17,
                                               direction: Totoslg::Stage::DIR_LEFT }
                                           ]
                                  }]
                       )
