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
        var awayTeam = ""
        var homeScore = 0
        var awayScore = 0
        var gdata: GameData = GameData(homeTeam: "a",awayTeam: "z",homeScore: 3,awayScore: 4)
        let nbaURL = urlBase + "?GameDate=" + b + "&LeagueID=00&DayOffset=0"
        Alamofire.request(nbaURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfGames: Int = json["resultSets"][0]["rowSet"].count
                for i in 0...numberOfGames-1 {
                    homeTeam = self.mappedValues(teamName: String(describing: json["resultSets"][0]["rowSet"][i][6]))
                    awayTeam = self.mappedValues(teamName: String(describing: json["resultSets"][0]["rowSet"][i][7]))
                    homeScore = json["resultSets"][1]["rowSet"][2*i][21].intValue
                    awayScore = json["resultSets"][1]["rowSet"][2*i + 1][21].intValue
                    print(homeTeam)
                    print(awayTeam)
                    print(homeScore)
                    print(awayScore)
                    gdata = GameData(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: homeScore, awayScore: awayScore)
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
            print(gamesArray.count)
            destination.gamesArray = gamesArray
            
        }
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

