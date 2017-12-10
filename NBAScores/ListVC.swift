//
//  ListVC.swift
//  NBAScores
//
//  Created by Chris Chiang on 12/5/17.
//  Copyright © 2017 Chris Chiang. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var gamesArray = [GameData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetBoxscore" {
            let dest = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            dest.game = gamesArray[index]
        }
    }

}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        cell.textLabel?.text = gamesArray[indexPath.row].homeTeamId + " vs. " + gamesArray[indexPath.row].awayTeamId
        cell.detailTextLabel?.text = "Final Score: \(String(describing: gamesArray[indexPath.row].homeScore)) - \(String(describing: gamesArray[indexPath.row].awayScore))"
        return cell
    }
}
