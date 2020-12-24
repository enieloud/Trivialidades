//
//  GameViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import UIKit

class GameViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var step: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var answers: UITableView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var feedback: UILabel!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let g = appDelegate.game {
            return g.possibleAnswers.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriviaAnswerViewCell", for: indexPath)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let g = appDelegate.game {
            cell.textLabel?.text = g.possibleAnswers[indexPath.row]
            return cell
        } else {
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answers.rowHeight = 24
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bindData()
    }
    
    func bindData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let g = appDelegate.game {
            step.text = g.currentStepStr
            score.text = g.scoreStr
            question.text = g.questionStr
            category.text = g.categoryStr
            buttonNext.isHidden = true
            buttonCheck.isHidden = false
        } else {
            buttonNext.isHidden = true
            buttonCheck.isHidden = true
            step.text = ""
            score.text = ""
            question.text = ""
            category.text = ""
        }
        feedback.text = ""
        answers.reloadData()
    }

    @IBAction func buttonCheckTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let g = appDelegate.game {
            if let currentIndex = answers.indexPathForSelectedRow?.row {
                if g.evalAnswer(index: currentIndex) {
                    feedback.textColor = .systemGreen
                    feedback.text = "That's right!"
                } else {
                    feedback.textColor = .systemRed
                    feedback.text = "Wrong answer!"
                }
                buttonNext.isHidden = false
                buttonCheck.isHidden = true
            }
        } else {
            buttonNext.isHidden = true
            buttonCheck.isHidden = true
        }
    }
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let g = appDelegate.game {
            if g.isFinihed() {
                // algo hay que hacer acá
            } else {
                g.next()
            }
        }
        bindData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
