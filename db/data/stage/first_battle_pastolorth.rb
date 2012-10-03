Totoslg::Stage.define( :FirstBattlePastolorth, 
                       map_source: :"FirstBattle",
                       name:       "First battle pastolorth",
                       details:    "test",
                       players: [ {
                                    units: [ { character_source: :"Pastolorth",
                                               x: 3,
                                               y: 8,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 4,
                                               y: 7,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 4,
                                               y: 9,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 2,
                                               y: 7,
                                               direction: Totoslg::Stage::DIR_RIGHT },
                                             { character_source: :"BeanF",
                                               x: 2,
                                               y: 9,
                                               direction: Totoslg::Stage::DIR_RIGHT }
                                           ]
                                  },
                                  {
                                    units: [ { character_source: :"Roun",
                                               x: 10,
                                               y: 7,
                                               direction: Totoslg::Stage::DIR_LEFT
                                             }
                                           ]
                                  }]
                       )
