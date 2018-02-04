//
//  TestCollectionViewCell.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 12/6/17.
//  Copyright © 2017 Fractal. All rights reserved.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell,ConfigurableCell {
    
    weak var delegate:actionAbleCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:-  Configurable cell
    typealias T = String    //providing type alias are optional as it can be interpreted from the function signature
    
    static var nibForCell: String {
        return "TestCollectionViewCell"
    }

    func configure(_ item: String, at indexPath: IndexPath) {
        self.titleLabel.text = item
    }
}
