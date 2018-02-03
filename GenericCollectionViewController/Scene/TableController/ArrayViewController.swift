//
//  ViewController.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 12/5/17.
//  Copyright © 2017 Fractal. All rights reserved.
//

import UIKit


/// Create the concrete class of datasource..add additional properties to customise the collection/tableview.
///specify the cell that is to be used and the data type here it is string.
class ArrayDataSource: TableArrayDataSource<String, TestTableViewCell> {
    var cellActionDelegate:actionAbleCellDelegate?
    
    override func modifyOrUpdate(cell:inout TestTableViewCell) {
        cell.delegate = cellActionDelegate
    }
}



class ViewController: UIViewController,actionAbleCellDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    let arrayData = ["AAA","BBB","CCC","DDD","EEE","FFF","GGG"]
    var arrayDataSource:ArrayDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////-----------------Array data-------------------------
        // Do any additional setup after loading the view, typically from a nib.
        arrayDataSource = ArrayDataSource(tableView: tableview, array: arrayData)

        //similarly other block can be defined for action in cell like edit on cell
        arrayDataSource?.tableItemSelectionHandler = { index in
            print("cell selected")
        }
        //this functionality was added on top of the basic generic collection type view generation and cell selection
        // this enables to take action on event like button action inside the cell.
        arrayDataSource?.cellActionDelegate = self
        //to handle some action on cell...like button action in cell
        
        
    }

    @IBAction func insertAtEndAction(_ sender: UIButton) {
        let index = IndexPath(row: arrayData.endIndex, section: 0)
        self.arrayDataSource?.insertItem(atIndex: index, value: "InsAtEnd")
    }
    
    @IBAction func insertAction(_ sender: UIButton) {
        let index = IndexPath(row:2, section: 0)
        self.arrayDataSource?.insertItem(atIndex: index, value: "insxxx")
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let index = IndexPath(row:2, section: 0)
        self.arrayDataSource?.deleteItem(atIndex: index)
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        let index = IndexPath(row:4, section: 0)
        self.arrayDataSource?.updateItem(at: index, value: "updated")
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

