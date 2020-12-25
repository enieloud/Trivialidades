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
    var showAnswers = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answers.rowHeight = 24
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buttonNext.setTitle("Next", for: .normal)
        bindData()
    }
    
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
            let text = String(htmlEncodedString: g.possibleAnswers[indexPath.row])
            cell.textLabel?.text = text
            if showAnswers {
                if g.isCorrect(index: indexPath.row) {
                    cell.backgroundColor = .init(red: 0.7, green: 1.0, blue: 0.7, alpha: 0.5)
                } else {
                    cell.backgroundColor = .init(red: 1.0, green: 0.7, blue: 0.7, alpha: 0.5)
                }
            } else {
                cell.backgroundColor = .white
            }
            return cell
        } else {
            cell.textLabel?.text = ""
        }
        return cell
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
                showAnswers = true
                answers.reloadData()
                if g.isFinihed() {
                    buttonNext.setTitle("View your score", for: .normal)
                }
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
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let finalScoreVC = storyBoard.instantiateViewController(withIdentifier: "FinalScoreViewControllerID") as! FinalScoreViewController
                finalScoreVC.modalPresentationStyle = .fullScreen
                self.present(finalScoreVC, animated: true, completion: nil)
            } else {
                showAnswers = false
                g.next()
            }
        }
        bindData()
    }
}
