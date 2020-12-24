//
//  CategoryTableViewController.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    var categ: TriviaCategories?
    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
    }
    override func viewDidAppear(_ animated: Bool) {
        readTriviaCategories { (categories: TriviaCategories?) in
            DispatchQueue.main.async { [unowned self] in
                if let c = categories {
                    self.categ = c
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = categ {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = categ {
            return c.triviaCategories.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let c = categ {
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
        if let c = categ {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.game.categoryId = c.triviaCategories[indexPath.row].id
        }
    }
}
