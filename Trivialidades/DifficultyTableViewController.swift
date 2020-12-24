//
//  DifficultyTableViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import UIKit

class DifficultyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Difficulty.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "difficultyViewCell", for: indexPath)
        cell.textLabel?.text = difficultyDescription( Difficulty.allCases[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.game.difficulty = Difficulty.allCases[indexPath.row]
    }
}
