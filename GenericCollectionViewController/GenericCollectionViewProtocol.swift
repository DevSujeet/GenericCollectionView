//
//  GenericViewProtocol.swift
//  Cuddle
//
//  Created by Sujeet.Kumar on 12/4/17.
//  Copyright © 2017 Fractal Analytics Inc. All rights reserved.
//

import Foundation
import UIKit

//resuable cell
public protocol ReusableCell {
    static var reuseIdentifierForCell: String { get }
    static var nibForCell:String { get }
}

public extension ReusableCell {
    static var reuseIdentifierForCell: String {
        return String(describing: self)
    }
}

//ConfigurableCell
public protocol ConfigurableCell: ReusableCell {
    associatedtype T
    
    func configure(_ item: T, at indexPath: IndexPath)
}

//Abstracting the Data Source: DataProvider
public protocol DataProviderProtocol {
    associatedtype T
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    func titleAtSection(in section: Int) ->String
}

public protocol ArrayDataProviderProtocol : DataProviderProtocol{
    func updateItem(at indexPath: IndexPath, value: T) ->Bool
    func insertItem(atIndex index:IndexPath , value:T) ->Bool
    func deleteItem(atIndex index:IndexPath) ->Bool
}

public protocol DictioanryDataProviderProtocol: DataProviderProtocol{
    associatedtype K
    func updateItem(at indexPath: IndexPath, value: T) ->Bool
    func updateItem(atfor key: K, value: T, atRow row:Int) ->IndexPath?
    func insertItem(atfor key: K, value: T, atRow row:Int) ->IndexPath?
    func deleteItem(atfor key: K, atRow row:Int) ->IndexPath?
    func deleteItem(whereKey key:K, value:T) ->IndexPath?
}


//define the action on collectioncell/tableCell
public typealias ItemSelectionHandlerType = (IndexPath) -> Void
//public typealias cellActionHandlerType = ()

