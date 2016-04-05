//
//  SudokuCell.swift
//  Sudoku
//
//  Created by Nishant on 2016-04-03.
//  Copyright © 2016 Epicara. All rights reserved.
//

import UIKit

class SudokuCell: UICollectionViewCell
{
    @IBOutlet weak var cellText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
