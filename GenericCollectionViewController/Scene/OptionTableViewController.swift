//
//  OptionTableViewController.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 2/3/18.
//  Copyright © 2018 Fractal. All rights reserved.
//

import UIKit

class OptionTableViewController: UITableViewController {

    let option = ["Array Controller","Dictionary Controller"]
    override func viewDidLoad() {
        
        print("OptionTableViewController view did load")
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(UINib(nibName:"OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return option.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
            cell.titleLabel?.text = option[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //push array controller
            let arrayViewController = self.storyboard?.instantiateViewController(withIdentifier: "ArrayViewController") as! ViewController
            self.navigationController?.pushViewController(arrayViewController, animated: true)
        }
        if indexPath.row == 1 {
            //push Dictionary controller
            let dicViewController = self.storyboard?.instantiateViewController(withIdentifier: "DictViewController") as! DictionaryViewController
            self.navigationController?.pushViewController(dicViewController, animated: true)
        }
    }
}
