//
//  CategoryTableViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.game.readCategories { (success: Bool) in
            DispatchQueue.main.async { [unowned self] in
                if !success {
                    DispatchQueue.main.async { [unowned self] in
                        let alert = UIAlertController(title: "Error", message: "Please check your Internet connection!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let _ = appDelegate.game.categ {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let c = appDelegate.game.categ  {
            return c.triviaCategories.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let c = appDelegate.game.categ  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryViewCell", for: indexPath)
            cell.textLabel?.text = c.triviaCategories[indexPath.row].name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryViewCell", for: indexPath)
            cell.textLabel?.text = ""
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let c = appDelegate.game.categ  {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.game.categoryId = c.triviaCategories[indexPath.row].id
        }
    }
}
