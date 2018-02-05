//
//  ArrayCollectionViewController.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 12/6/17.
//  Copyright © 2017 Fractal. All rights reserved.
//

import UIKit
class ArrayCollectionDataSource: CollectionArrayDataSource<String, TestCollectionViewCell> {
    var cellActionDelegate:actionAbleCellDelegate?
    
    override func modifyOrUpdate(cell:inout TestCollectionViewCell) {
        cell.delegate = cellActionDelegate
        cell.backgroundColor = UIColor.red
    }
    //MARK:- flowdelegate settin info
    let minimumInteritemSpacing = 0.0
    
    let minimumLineSpacing = 0.0
    
    let padding:CGFloat = 0.0
    
    let itemsPerRow: CGFloat = 2
    
    var sectionInsets:UIEdgeInsets {
        get {
            return UIEdgeInsets(top:padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    var view :UIView {
        get {
            return self.collectionView.superview!
        }
        
    }
    
    override func setUp() {
        super.setUp()
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = CGFloat(minimumInteritemSpacing)
        flowLayout.minimumLineSpacing = CGFloat(minimumLineSpacing)
        
        //        flowLayout.setItemSize = CGSizeMake(50.0f, 50.0f)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let normalSize = CGSize(width: widthPerItem, height: widthPerItem)
        
        let isLarge = isLargeCellType(at: indexPath)
        if isLarge {
            let largeSize = CGSize(width: widthPerItem * itemsPerRow + sectionInsets.left, height: widthPerItem * 1.0 )
            return largeSize
        }
        return normalSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}

extension ArrayCollectionDataSource : UICollectionViewDelegateFlowLayout {
    //overirde in subclass to specify the large cell type.
    func isLargeCellType(at indexPath:IndexPath) -> Bool {
        let row = indexPath.row
        if row == 1 || row == 3 || row == 4 {
            return true
        }
        return false
    }
}


class ArrayCollectionViewController: UIViewController,actionAbleCellDelegate{
    

    
     //MARk:- Controller setup
    @IBOutlet weak var collectionView: UICollectionView!
    
    let arrayData = ["AAA","BBB","CCC","DDD","EEE","FFF","GGG"]
    var arrayCollectionDataSource:ArrayCollectionDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        ////-----------------Array data-------------------------
        // Do any additional setup after loading the view, typically from a nib.
        arrayCollectionDataSource = ArrayCollectionDataSource(collectionView: self.collectionView, array: arrayData)
        
        //similarly other block can be defined for action in cell like edit on cell
        arrayCollectionDataSource?.collectionItemSelectionHandler = { index in
            print("cell selected at index = \(index)")
        }
        //this functionality was added on top of the basic generic collection type view generation and cell selection
        // this enables to take action on event like button action inside the cell.
        arrayCollectionDataSource?.cellActionDelegate = self
        //to handle some action on cell...like button action in cell
        
        //setting the layout of the collection view

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func insertAtEndAction(_ sender: UIButton) {
        let index = IndexPath(row: arrayData.endIndex, section: 0)
        self.arrayCollectionDataSource?.insertItem(atIndex: index, value: "InsAtEnd")
    }
    
    @IBAction func insertAction(_ sender: UIButton) {
        let index = IndexPath(row:2, section: 0)
        self.arrayCollectionDataSource?.insertItem(atIndex: index, value: "insxxx")
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let index = IndexPath(row:2, section: 0)
        self.arrayCollectionDataSource?.deleteItem(atIndex: index)
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        let index = IndexPath(row:4, section: 0)
        self.arrayCollectionDataSource?.updateItem(at: index, value: "updated")
    }

    //MARK:- Cell action handling
    func actionInsideCell(data:String) {
        print("Message from cell = \(data)")
        print("handling from inside of the controller")
    }
}


