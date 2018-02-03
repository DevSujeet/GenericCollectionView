//
//  TestTableViewCell.swift
//  GenericCollectionViewController
//
//  Created by Sujeet.Kumar on 12/5/17.
//  Copyright © 2017 Fractal. All rights reserved.
//

import UIKit


public protocol actionAbleCellDelegate:NSObjectProtocol{
    func actionInsideCell(data:String)
}

//Generally cell should be not aware of the data.
class TestTableViewCell: UITableViewCell,ConfigurableCell {

     weak var delegate:actionAbleCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- ConfigurableCell protocol
    //NOTE:-also set the identifier in the xib with same name
    //is this necessary..looks like works without putting the identifier in the xib.
    static var nibForCell: String {
        return "TestTableViewCell"
    }
    
    func configure(_ item: String, at indexPath: IndexPath) {
        label.text = item
    }

    //MARK:- Cell IBAction
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        self.delegate?.actionInsideCell(data: "Action inside cell")
    }
    
}
