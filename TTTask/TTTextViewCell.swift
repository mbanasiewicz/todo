//
//  TTTextViewCell.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 13/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

let TTTextViewCellRI = "TTTextViewCell"
class TTTextViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.font = UIFont(name:TTDefaultFontName, size: 16.0)
        selectionStyle = .None
    }
}
