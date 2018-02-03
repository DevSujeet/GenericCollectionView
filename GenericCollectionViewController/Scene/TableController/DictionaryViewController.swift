//
//  DictionaryViewController.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 2/3/18.
//  Copyright © 2018 Fractal. All rights reserved.
//

import Foundation
import UIKit


/// Create the concrete class of datasource..add additional properties to customise the collection/tableview.
///specify the cell that is to be used and the data type here it is string.

class DictionaryDataSource: TableDictionaryDataSource<String,String, TestTableViewCell> {
    var cellActionDelegate:actionAbleCellDelegate?
    
    override func modifyOrUpdate(cell:inout TestTableViewCell) {
        cell.delegate = cellActionDelegate
    }
}

class DictionaryViewController: UIViewController,actionAbleCellDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    let dicData = ["Category": ["All","Well Done!", "Cuddle Support", "Alert"], "Responsibility": ["902", "901"],"career":["Eng","Doc","laywer"] ]
    
    var dicDataSource:DictionaryDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////-----------------Dictionary data-------------------------
        
        dicDataSource = DictionaryDataSource(tableView: tableview, dictionary: dicData)
        dicDataSource?.tableItemSelectionHandler = { index in
            print("cell selected")
        }
        dicDataSource?.cellActionDelegate = self
    }
    
    @IBAction func insertAtEndAction(_ sender: UIButton) {
        dicDataSource?.insertItem(atfor: "career", value: "actor1",atRow: 4)
    }
    
    @IBAction func insertAction(_ sender: UIButton) {
        dicDataSource?.insertItem(atfor: "career", value: "actor")
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        dicDataSource?.deleteItem(whereKey: "career", value: "actor1")
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        let index = IndexPath(row: 1, section: 1)
        dicDataSource?.updateItem(at: index, value: "New update")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Cell action handling
    func actionInsideCell(data:String) {
        print("Message from cell = \(data)")
        print("handling from inside of the controller")
    }
    
}

