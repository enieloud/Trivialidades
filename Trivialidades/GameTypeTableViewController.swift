//
//  GameTypeTableViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import UIKit

class GameTypeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameTypeViewCell", for: indexPath)
        cell.textLabel?.text = QuestionType.allCases[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.game.type = QuestionType.allCases[indexPath.row]
        appDelegate.game.newGame() { (succeed: Bool) in
            if appDelegate.game.questionsAndAnswers.results.count > 0
            {
                DispatchQueue.main.async { [unowned self] in
                    if succeed {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewControllerID") as! GameViewController
                        self.navigationController!.pushViewController(vc, animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async { [unowned self] in
                    let alert = UIAlertController(title: "Error", message: "You can't combine Hard level with Yes/No Questions!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
