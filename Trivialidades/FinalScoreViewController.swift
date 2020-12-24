//
//  FinalScoreViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 24/12/2020.
//

import UIKit

class FinalScoreViewController: UIViewController {

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        finalScoreLabel.text = "Your final score is \(appDelegate.game.scoreStr) / \(appDelegate.game.amount)"
    }
}
