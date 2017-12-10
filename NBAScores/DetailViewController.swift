//
//  DetailViewController.swift
//  NBAScores
//
//  Created by Chris Chiang on 12/5/17.
//  Copyright © 2017 Chris Chiang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var game: GameData?
    
    @IBOutlet weak var homeTeamPicture: UIImageView!
    @IBOutlet weak var awayTeamPicture: UIImageView!
    @IBOutlet weak var CurrentOrFinal: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeTeamInitials: UILabel!
    @IBOutlet weak var awayTeamInitials: UILabel!
    @IBOutlet weak var homeq1: UILabel!
    @IBOutlet weak var homeq2: UILabel!
    @IBOutlet weak var homeq3: UILabel!
    @IBOutlet weak var homeq4: UILabel!
    @IBOutlet weak var awayq1: UILabel!
    @IBOutlet weak var awayq2: UILabel!
    @IBOutlet weak var awayq3: UILabel!
    @IBOutlet weak var awayq4: UILabel!
    @IBOutlet weak var homeOT: UILabel!
    @IBOutlet weak var awayOT: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = game {
            homeTeam.text = game.homeTeamId
            awayTeam.text = game.awayTeamId
            homeTeamInitials.text = game.homeTeamInitials
            awayTeamInitials.text = game.awayTeamInitials
            homeTeamPicture.image = UIImage(named: game.homeTeamInitials)
            awayTeamPicture.image = UIImage(named: game.awayTeamInitials)
            homeScore.text = String(game.homeScore)
            awayScore.text = String(game.awayScore)
            homeq1.text = String(game.quarterScoreHome.q1)
            homeq2.text = String(game.quarterScoreHome.q2)
            homeq3.text = String(game.quarterScoreHome.q3)
            homeq4.text = String(game.quarterScoreHome.q4)
            homeOT.text = String(game.quarterScoreAway.OT)
            awayq1.text = String(game.quarterScoreAway.q1)
            awayq2.text = String(game.quarterScoreAway.q2)
            awayq3.text = String(game.quarterScoreAway.q3)
            awayq4.text = String(game.quarterScoreAway.q4)
            awayOT.text = String(game.quarterScoreAway.OT)

            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
