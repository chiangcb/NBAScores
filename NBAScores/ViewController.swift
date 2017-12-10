//
//  ViewController.swift
//  NBAScores
//
//  Created by Chris Chiang on 12/4/17.
//  Copyright © 2017 Chris Chiang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {

    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var FindGamesButton: UIButton!
    var gamesArray = [GameData]()
    var month: Int = -1
    var day: Int = -1
    var year: Int = -1
    var monthDateYear: String!
    var calendar = Calendar.current
    override func viewDidLoad() {
        super.viewDidLoad()
        var components = calendar.dateComponents([.day, .month, .year], from: DatePicker.date)
        month = components.month!
        day = components.day!
        year = components.year!
        monthDateYear = "\(month)/\(day)/\(year)"
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        var components = calendar.dateComponents([.day, .month, .year], from: DatePicker.date)
        month = components.month!
        day = components.day!
        year = components.year!
        monthDateYear = "\(month)/\(day)/\(year)"

    }
    func getGameData(b: String) {
        var homeTeam = ""
        var homeTeamInitials = ""
        var awayTeamInitials = ""
        var awayTeam = ""
        var homeScore = 0
        var awayScore = 0
        var gdata: GameData! = nil
        var quarterScoreHome: ScoreByQuarter = ScoreByQuarter(q1: 0, q2: 0, q3: 0, q4: 0, OT: 0)
        var quarterScoreAway: ScoreByQuarter = ScoreByQuarter(q1: 0, q2: 0, q3: 0, q4: 0, OT: 0)
        let nbaURL = urlBase + "?GameDate=" + b + "&LeagueID=00&DayOffset=0"
        Alamofire.request(nbaURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfGames: Int = json["resultSets"][0]["rowSet"].count
                for i in 0...numberOfGames-1 {
                    homeTeamInitials = self.mappedValues2(teamName: String(describing: json["resultSets"][0]["rowSet"][i][6]))
                    awayTeamInitials = self.mappedValues2(teamName: String(describing: json["resultSets"][0]["rowSet"][i][7]))
                    homeTeam = self.mappedValues(teamName: String(describing: json["resultSets"][0]["rowSet"][i][6]))
                    awayTeam = self.mappedValues(teamName: String(describing: json["resultSets"][0]["rowSet"][i][7]))
                    homeScore = json["resultSets"][1]["rowSet"][2*i][21].intValue
                    awayScore = json["resultSets"][1]["rowSet"][2*i + 1][21].intValue
                    quarterScoreHome.q1 = json["resultSets"][1]["rowSet"][2*i][7].intValue
                    quarterScoreHome.q2 = json["resultSets"][1]["rowSet"][2*i][8].intValue
                    quarterScoreHome.q3 = json["resultSets"][1]["rowSet"][2*i][9].intValue
                    quarterScoreHome.q4 = json["resultSets"][1]["rowSet"][2*i][10].intValue
                    quarterScoreAway.q1 = json["resultSets"][1]["rowSet"][2*i + 1][7].intValue
                    quarterScoreAway.q2 = json["resultSets"][1]["rowSet"][2*i + 1][8].intValue
                    quarterScoreAway.q3 = json["resultSets"][1]["rowSet"][2*i + 1][9].intValue
                    quarterScoreAway.q4 = json["resultSets"][1]["rowSet"][2*i + 1][10].intValue
                    print(homeTeam)
                    print(awayTeam)
                    print(homeScore)
                    print(awayScore)
                    gdata = GameData(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: homeScore, awayScore: awayScore, quarterScoreHome: quarterScoreHome, quarterScoreAway: quarterScoreAway, homeTeamInitials: homeTeamInitials, awayTeamInitials: awayTeamInitials)
                    self.gamesArray.append(gdata)
                    print(self.gamesArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        getGameData(b: monthDateYear)
        let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.segueToListVC()
        }

    }
    func segueToListVC() {
        performSegue(withIdentifier: "ToListVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToListVC" {
            let destination = segue.destination as! ListVC
            // let destination = dvc.topViewController as! ListVC
            print(gamesArray.count)
            destination.gamesArray = gamesArray
            gamesArray = [GameData]()
        }
    }
    func mappedValues2(teamName: String) -> String {
        var newTeamName: String = ""
        if teamName == "1610612737" {
            newTeamName = "ATL"
        }
        else if teamName == "1610612738" {
            newTeamName = "BOS"
        }
        else if teamName == "1610612751" {
            newTeamName = "BKN"
        }
        else if teamName == "1610612766" {
            newTeamName = "CHA"
        }
        else if teamName == "1610612741" {
            newTeamName = "CHI"
        }
        else if teamName == "1610612739" {
            newTeamName = "CLE"
        }
        else if teamName == "1610612742" {
            newTeamName = "DAL"
        }
        else if teamName == "1610612743" {
            newTeamName = "DEN"
        }
        else if teamName == "1610612765" {
            newTeamName = "DET"
        }
        else if teamName == "1610612744" {
            newTeamName = "GSW"
        }
        else if teamName == "1610612745" {
            newTeamName = "HOU"
        }
        else if teamName == "1610612754" {
            newTeamName = "IND"
        }
        else if teamName == "1610612746" {
            newTeamName = "LAC"
        }
        else if teamName == "1610612747" {
            newTeamName = "LAL"
        }
        else if teamName == "1610612763" {
            newTeamName = "MEM"
        }
        else if teamName == "1610612748" {
            newTeamName = "MIA"
        }
        else if teamName == "1610612749" {
            newTeamName = "MIL"
        }
        else if teamName == "1610612750" {
            newTeamName = "MIN"
        }
        else if teamName == "1610612740" {
            newTeamName = "NOP"
        }
        else if teamName == "1610612752" {
            newTeamName = "NYK"
        }
        else if teamName == "1610612760" {
            newTeamName = "OKC"
        }
        else if teamName == "1610612753" {
            newTeamName = "ORL"
        }
        else if teamName == "1610612755" {
            newTeamName = "PHI"
        }
        else if teamName == "1610612756" {
            newTeamName = "PHX"
        }
        else if teamName == "1610612757" {
            newTeamName = "POR"
        }
        else if teamName == "1610612758" {
            newTeamName = "SAC"
        }
        else if teamName == "1610612759" {
            newTeamName = "SAS"
        }
        else if teamName == "1610612761" {
            newTeamName = "TOR"
        }
        else if teamName == "1610612762" {
            newTeamName = "UTA"
        }
        else if teamName == "1610612764" {
            newTeamName = "WAS"
        }
        return newTeamName
    }
    
    func mappedValues(teamName: String) -> String {
        var newTeamName: String = ""
        if teamName == "1610612737" {
            newTeamName = "Atlanta Hawks"
        }
        else if teamName == "1610612738" {
            newTeamName = "Boston Celtics"
        }
        else if teamName == "1610612751" {
            newTeamName = "Brooklyn Nets"
        }
        else if teamName == "1610612766" {
            newTeamName = "Charlotte Hornets"
        }
        else if teamName == "1610612741" {
            newTeamName = "Chicago Bulls"
        }
        else if teamName == "1610612739" {
            newTeamName = "Cleveland Cavaliers"
        }
        else if teamName == "1610612742" {
            newTeamName = "Dallas Mavericks"
        }
        else if teamName == "1610612743" {
            newTeamName = "Denver Nuggets"
        }
        else if teamName == "1610612765" {
            newTeamName = "Detroit Pistons"
        }
        else if teamName == "1610612744" {
            newTeamName = "Golden State Warriors"
        }
        else if teamName == "1610612745" {
            newTeamName = "Houston Rockets"
        }
        else if teamName == "1610612754" {
            newTeamName = "Indiana Pacers"
        }
        else if teamName == "1610612746" {
            newTeamName = "Los Angeles Clippers"
        }
        else if teamName == "1610612747" {
            newTeamName = "Los Angeles Lakers"
        }
        else if teamName == "1610612763" {
            newTeamName = "Memphis Grizzlies"
        }
        else if teamName == "1610612748" {
            newTeamName = "Miami Heat"
        }
        else if teamName == "1610612749" {
            newTeamName = "Milwaukee Bucks"
        }
        else if teamName == "1610612750" {
            newTeamName = "Minnesota Timberwolves"
        }
        else if teamName == "1610612740" {
            newTeamName = "New Orleans Pelicans"
        }
        else if teamName == "1610612752" {
            newTeamName = "New York Knicks"
        }
        else if teamName == "1610612760" {
            newTeamName = "Oklahoma City Thunder"
        }
        else if teamName == "1610612753" {
            newTeamName = "Orlando Magic"
        }
        else if teamName == "1610612755" {
            newTeamName = "Philadelphia 76ers"
        }
        else if teamName == "1610612756" {
            newTeamName = "Phoenix Suns"
        }
        else if teamName == "1610612757" {
            newTeamName = "Portland Trail Blazers"
        }
        else if teamName == "1610612758" {
            newTeamName = "Sacramento Kings"
        }
        else if teamName == "1610612759" {
            newTeamName = "San Antonio Spurs"
        }
        else if teamName == "1610612761" {
            newTeamName = "Toronto Raptors"
        }
        else if teamName == "1610612762" {
            newTeamName = "Utah Jazz"
        }
        else if teamName == "1610612764" {
            newTeamName = "Washington Wizards"
        }
        return newTeamName
    }
    
}

