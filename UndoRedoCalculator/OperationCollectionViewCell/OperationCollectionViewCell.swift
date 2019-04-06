//
//  operationCollectionViewCell.swift
//  CommandPatternUndoRedo
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import UIKit

class OperationCollectionViewCell: UICollectionViewCell {

    static let identifier =  "OperationCollectionViewCell"
    static let nibName = "OperationCollectionViewCell"
    private(set) static var labelFont:UIFont = UIFont.systemFont(ofSize: 17)
    
    @IBOutlet weak var operationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        operationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        operationLabel.layer.borderWidth = 4
        operationLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        operationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        operationLabel.font = OperationCollectionViewCell.labelFont
    }
    

}
