//
//  CustomButton.swift
//  Sudoku
//
//  Created by Nishant on 2016-04-05.
//  Copyright © 2016 Epicara. All rights reserved.
//

import Foundation
import UIKit

class SButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = colSemiRed.CGColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = colDemiRed
        self.tintColor = UIColor.whiteColor()
        self.setTitleColor(colLightYellow, forState: UIControlState.Selected)
        
    }
}