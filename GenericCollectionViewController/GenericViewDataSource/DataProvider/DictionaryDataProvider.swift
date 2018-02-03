//
//  DictionaryDataProvider.swift
//  Cuddle
//
//  Created by Sujeet.Kumar on 12/4/17.
//  Copyright © 2017 Fractal Analytics Inc. All rights reserved.
//

import Foundation
import UIKit

extension DictionaryDataProvider :DictioanryDataProviderProtocol {
    
    public func updateItem(at indexPath: IndexPath, value: T) -> Bool {
        guard indexPath.section >= 0 &&
            indexPath.section < items.keys.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[self.keyAt(section: indexPath.section)]!.count else
        {
            print("DictionaryDataProvider updateItem:- indexpath not found")
            return false
        }
        var arrayAtIndex = items[self.keyAt(section: indexPath.section)]!
        arrayAtIndex[indexPath.row] = value
        items[self.keyAt(section: indexPath.section)] = arrayAtIndex
        return true
    }
    
    func updateItem(atfor key: U, value: T, atRow row: Int) -> IndexPath? {
        var updatedIndex:IndexPath?
        var arrayForKey = items[key]
        guard arrayForKey != nil && row < (arrayForKey?.count)!  else {
            print("DictionaryDataProvider updateItem:- indexpath not found")
            return nil
        }
        arrayForKey![row] = value
        items[key] = arrayForKey
        
        let sectionInfo = self.sectionInfo(forKey: key)
        let rowInfo = row
        updatedIndex = IndexPath(row: rowInfo, section: sectionInfo!)
        return updatedIndex
    }
    
    func insertItem(atfor key: U, value: T, atRow row: Int = 0) -> IndexPath? {
        var insertIndex:IndexPath?
        var arrayForKey = items[key]
        guard arrayForKey != nil &&  row <= (arrayForKey?.count)! else {
            print("DictionaryDataProvider insertItem:- array not found or insertion beyond the array range")
            return nil
        }
        arrayForKey!.insert(value, at: row)
        items[key] = arrayForKey
        
        let sectionInfo = self.sectionInfo(forKey: key)
        let rowInfo = row
        insertIndex = IndexPath(row: rowInfo, section: sectionInfo!)
        
        return insertIndex
    }
    
    func deleteItem(atfor key: U, atRow row: Int) -> IndexPath? {
        var deleteIndex:IndexPath?
        var arrayForKey = items[key]
        guard arrayForKey != nil && row < (arrayForKey?.count)!  else {
            print("DictionaryDataProvider deleteItem:- array not found or deletion beyond the array range")
            return nil
        }
        arrayForKey!.remove(at: row)
        items[key] = arrayForKey
        
        let sectionInfo = self.sectionInfo(forKey: key)
        deleteIndex = IndexPath(row: row, section: sectionInfo!)
        return deleteIndex
    }
    
    func deleteItem(whereKey key: U, value: T) -> IndexPath? {
        var deleteIndex:IndexPath?
        var arrayAtKey = items[key]
        guard (arrayAtKey != nil) && arrayAtKey!.count > 0 else {
            print("DictionaryDataProvider deleteItem:- section for key not found")
            return nil
        }
        
        if let rowOfValue = isItemPresent(item: value, inArray: arrayAtKey!) {
            arrayAtKey?.remove(at: rowOfValue)
            items[key] = arrayAtKey
            
            let sectionInfo = self.sectionInfo(forKey: key)
            deleteIndex = IndexPath(row: rowOfValue, section: sectionInfo!)
            return deleteIndex
        }
        print("DictionaryDataProvider deleteItem:- value doesnt exit")
        return deleteIndex
    }


    
    typealias K = U
    
    public func numberOfSections() -> Int {
        return items.keys.count
    }
    public func numberOfItems(in section: Int) -> Int {
        
        guard section >= 0 && section < items.keys.count else {
            return 0
        }
        let keyForSection = self.keyAt(section: section)
        let arrayOfObject = items[keyForSection]
        
        return arrayOfObject?.count ?? 0
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        
        guard indexPath.section >= 0 &&
            indexPath.section < items.keys.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[self.keyAt(section: indexPath.section)]!.count else
        {
            return nil
        }
        return items[self.keyAt(section: indexPath.section)]![indexPath.row]
    }
    
    public func titleAtSection(in section: Int) -> String {
        return self.keyAt(section: section).description
    }
    

}

class DictionaryDataProvider<U:Hashable & CustomStringConvertible,T:Comparable> {
        
    // MARK: - Internal Properties
    var items: [U:[T]] = [:]
    
    // MARK: - Lifecycle
    init(dict: [U:[T]]) {
        items = dict
    }
    
    // MARK: - CollectionDataProvider
    
    
    
    //MARK:- Private Function
    //override in subClass/Concrete class to get desired result
    private func keyAt(section:Int) -> U {
        let key = Array(items.keys)[section]
        return key
    }
    
    private func sectionInfo(forKey key:U) -> Int?{
        let arrayOfKey = Array(items.keys)
        for (index,value) in arrayOfKey.enumerated() {
            if(key == value) {
                return index
            }
        }
        
        return nil
    }

    private func isItemPresent(item searchItem:T, inArray array : [T]) ->Int? {
        
        var foundindex:Int?
        for (index,arrayitem) in array.enumerated() {
            if (searchItem == arrayitem){
                foundindex = index
            }
        }
        return foundindex
    }
}
