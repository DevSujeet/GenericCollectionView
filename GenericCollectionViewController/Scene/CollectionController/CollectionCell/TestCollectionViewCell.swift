//
//  TestCollectionViewCell.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 12/6/17.
//  Copyright © 2017 Fractal. All rights reserved.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell,ConfigurableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:-  Configurable cell
    static var nibForCell: String {
        return "TestCollectionViewCell"
    }
    
    func configure(_ item: String, at indexPath: IndexPath) {
        
    }
}
