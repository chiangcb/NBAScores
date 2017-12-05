//
//  GameData.swift
//  NBAScores
//
//  Created by Chris Chiang on 12/5/17.
//  Copyright © 2017 Chris Chiang. All rights reserved.
//

import Foundation
import Alamofire

class GameData {
    var homeTeamId = ""
    var awayTeamId = ""
    var homeScore: Int = 0
    var awayScore: Int = 0
 
    init(homeTeam: String, awayTeam: String, homeScore: Int, awayScore: Int) {
        self.homeTeamId = homeTeam
        self.awayTeamId = awayTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
    }
}
