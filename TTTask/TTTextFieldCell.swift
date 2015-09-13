//
//  TTTextFieldCell.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 13/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

let TTTextFieldCellRI = "TTTextFieldCell"
class TTTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.font = UIFont(name:TTDefaultFontName, size: 16.0)
        selectionStyle = .None
    }
}