//
//  ViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var categoryPicker: UIPickerView!
    var categories: TriviaCategories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readTriviaCategories(completion: { (triviaCategories: TriviaCategories?) in
            guard let categ = triviaCategories else {
                return
            }
            self.categories = categ
            DispatchQueue.main.async {
                self.categoryPicker.reloadAllComponents()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let categ = self.categories else {
            return 0
        }
        return categ.triviaCategories.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let categ = self.categories else {
            return ""
        }
        return categ.triviaCategories[row].name
    }
    
    @IBAction func Play(_ sender: Any) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.game.newGame(difficulty: .easy, type: .boolean, amount: 10, categoryId: 9) { (succeed: Bool) in
//            DispatchQueue.main.async { [unowned self] in
//                if succeed {
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewControllerID") as! GameViewController
//                    self.present(vc, animated: true)
//                }
//            }
//        }
    }
}

