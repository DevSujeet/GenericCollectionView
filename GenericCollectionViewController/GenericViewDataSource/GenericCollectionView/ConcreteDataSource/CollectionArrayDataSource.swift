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
            self.dataSourceWillChangeContent()
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView.reloadItems(at: [indexPath])
                    }
                })
            )
            
            self.dataSourceDidChangeContent()
        }
        
    }
    
    public func insertItem(atIndex index: IndexPath, value: T) {
        
        if provider.insertItem(atIndex: index, value: value) {
            self.dataSourceWillChangeContent()
            //-----------------
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView.insertItems(at: [index])
                    }
                })
            )
            //-----------------
            self.dataSourceDidChangeContent()
        }
        
    }
    
    public func deleteItem(atIndex index: IndexPath) {
        self.dataSourceWillChangeContent()
        if provider.deleteItem(atIndex: index) {
            self.dataSourceWillChangeContent()
            //-----------------
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView.deleteItems(at: [index])
                    }
                })
            )
            //-----------------
            self.dataSourceDidChangeContent()
        }
        self.dataSourceDidChangeContent()
    }

    
}
