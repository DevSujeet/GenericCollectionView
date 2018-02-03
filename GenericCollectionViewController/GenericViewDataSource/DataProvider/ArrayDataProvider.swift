//
//  ArrayDataProvider.swift
//  Cuddle
//
//  Created by Sujeet.Kumar on 12/4/17.
//  Copyright © 2017 Fractal Analytics Inc. All rights reserved.
//

import Foundation
import UIKit

public class ArrayDataProvider<U> {
    
    // MARK: - Internal Properties
    var items: [[U]] = []
    
    // MARK: - Lifecycle
    init(array: [[U]]) {
        items = array
    }
    
    private func numberOfSection() -> Int {
        return items.count
    }
    
    private func numberOfRow(atSection section:Int)->Int {
        //assuming section check is performed before calling this method
        let arrayAtSection = items[section]
        return arrayAtSection.count
    }
    
    // MARK: - CollectionDataProvider
//    public typealias T = U    //typealias is required if the class is non generic
    
}

extension ArrayDataProvider : ArrayDataProviderProtocol {
    public func item(at indexPath: IndexPath) -> U? {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else
        {
            return nil
        }
        return items[indexPath.section][indexPath.row]
    }
    
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    
    public func titleAtSection(in section: Int) -> String {
        return ""
    }
    
    public func updateItem(at indexPath: IndexPath, value: U)->Bool {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else
        {
            return false
        }
        items[indexPath.section][indexPath.row] = value
        return true
    }
    public func insertItem(atIndex index: IndexPath, value: U)->Bool {
        guard index.section >= 0 && index.section < numberOfSection() else  {
            print("ArrayDataProvider:- No section found")
            return false
        }
        var arrayAtSection = items[index.section]
        guard index.row >= 0 && index.row <= numberOfRow(atSection: index.section) else {
            print("ArrayDataProvider:- trying to enter data beyond the array row index")
            return false
        }
        arrayAtSection.insert(value, at: index.row)
        items[index.section] = arrayAtSection
        return true
    }
    
    public func deleteItem(atIndex index: IndexPath)->Bool {
        guard index.section >= 0 && index.section < numberOfSection() else  {
            print("ArrayDataProvider:- No section found")
            return false
        }
        var arrayAtSection = items[index.section]
        guard index.row >= 0 && index.row < numberOfRow(atSection: index.section) else {
            print("ArrayDataProvider:- trying to delete data beyond the array row index")
            return false
        }
        arrayAtSection.remove(at: index.row)
        items[index.section] = arrayAtSection
        return true
    }
}
