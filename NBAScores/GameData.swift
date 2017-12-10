//
//  GameData.swift
//  NBAScores
//
//  Created by Chris Chiang on 12/5/17.
//  Copyright © 2017 Chris Chiang. All rights reserved.
//

import Foundation
import Alamofire
struct ScoreByQuarter {
    var q1: Int
    var q2: Int
    var q3: Int
    var q4: Int
    var OT: Int
}

class GameData {
    var homeTeamId = ""
    var awayTeamId = ""
    var homeTeamInitials = ""
    var awayTeamInitials = ""
    var homeScore: Int = 0
    var awayScore: Int = 0
    var quarterScoreHome: ScoreByQuarter
    var quarterScoreAway: ScoreByQuarter
    init(homeTeam: String, awayTeam: String, homeScore: Int, awayScore: Int, quarterScoreHome: ScoreByQuarter, quarterScoreAway: ScoreByQuarter, homeTeamInitials: String, awayTeamInitials: String) {
        self.homeTeamId = homeTeam
        self.awayTeamId = awayTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.quarterScoreHome = quarterScoreHome
        self.quarterScoreAway = quarterScoreAway
        self.homeTeamInitials = homeTeamInitials
        self.awayTeamInitials = awayTeamInitials
    }
}
