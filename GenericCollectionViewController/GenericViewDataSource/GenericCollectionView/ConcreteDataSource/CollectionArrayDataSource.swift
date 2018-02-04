//
//  CollectionArrayDataSource.swift
//  Cuddle
//
//  Created by Sujeet.Kumar on 12/4/17.
//  Copyright © 2017 Fractal Analytics Inc. All rights reserved.
//

import Foundation
import UIKit

open class CollectionArrayDataSource<T, Cell: UICollectionViewCell>: CollectionDataSource<ArrayDataProvider<T>, Cell>where Cell: ConfigurableCell, Cell.T == T
{
    public convenience init(collectionView: UICollectionView, array: [T]) {
        self.init(collectionView: collectionView, array: [array])
    }
    
    public init(collectionView: UICollectionView, array: [[T]]) {
        let provider = ArrayDataProvider(array: array)
        super.init(collectionView: collectionView, provider: provider)
    }
    
    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        if provider.updateItem(at: indexPath, value: value) {
            //once data is update..start relod animation
//            self.tableView.beginUpdates()
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//            self.tableView.endUpdates()
        }
        
    }
    
    public func insertItem(atIndex index: IndexPath, value: T) {
        if provider.insertItem(atIndex: index, value: value) {
            //once data is update..start relod animation
//            self.tableView.beginUpdates()
//            tableView.insertRows(at: [index], with: .automatic)
//            self.tableView.endUpdates()
        }
        
    }
    
    public func deleteItem(atIndex index: IndexPath) {
        if provider.deleteItem(atIndex: index) {
            //once data is update..start relod animation
//            self.tableView.beginUpdates()
//            tableView.deleteRows(at: [index], with: .automatic)
//            self.tableView.endUpdates()
        }
    }

    
}
