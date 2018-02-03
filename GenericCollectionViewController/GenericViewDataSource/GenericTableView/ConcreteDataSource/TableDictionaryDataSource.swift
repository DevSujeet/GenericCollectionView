//
//  TableDictionaryDataSource.swift
//  Cuddle
//
//  Created by Sujeet.Kumar on 12/4/17.
//  Copyright © 2017 Fractal Analytics Inc. All rights reserved.
//

import Foundation
import UIKit

class TableDictionaryDataSource<U,T,Cell:UITableViewCell>:TableDataSource<DictionaryDataProvider<U,T>,Cell> where
Cell:ConfigurableCell,Cell.T == T , U:CustomStringConvertible & Hashable,T:Comparable{
    
    
    public init(tableView: UITableView, dictionary: [U:[T]]) {
        let provider = DictionaryDataProvider(dict: dictionary)
        super.init(tableView: tableView, provider: provider)
    }
    
    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        if provider.updateItem(at: indexPath, value: value) {
            //once data is update..start relod animation
            self.tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    public func updateItem(atfor key: U, value: T, atRow row: Int) {
        if let updateIndex = provider.updateItem(atfor: key, value: value, atRow: row) {
            //once data is update..start relod animation
            self.tableView.beginUpdates()
            tableView.reloadRows(at: [updateIndex], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    public func insertItem(atfor key: U, value: T, atRow row: Int = 0) {
        if let insertedIndex = provider.insertItem(atfor: key, value: value, atRow: row) {
            //once data is update..start relod animation
            self.tableView.beginUpdates()
            tableView.insertRows(at: [insertedIndex], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    public func deleteItem(atfor key: U, atRow row: Int) {
        if let deletedIndex = provider.deleteItem(atfor: key, atRow: row) {
            //once data is update..start relod animation
            self.tableView.beginUpdates()
            tableView.deleteRows(at: [deletedIndex], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    public func deleteItem(whereKey key: U, value: T) {
        if let deletedIndex = provider.deleteItem(whereKey: key, value: value) {
            //once data is update..start relod animation
            self.tableView.beginUpdates()
            tableView.deleteRows(at: [deletedIndex], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}
