//
//  TTToDoTableViewCell.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

let TTToDoTableViewCellRI = "TTToDoTableViewCell"

class TTToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoTitleLabel: UILabel!
    @IBOutlet weak var dateAddedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showsReorderControl = true
        shouldIndentWhileEditing = false
        indentationWidth = 0.0
        configureTitleLabel()
        configureDateAddedLabel()
    }
    
    
    func configureTitleLabel() {
        toDoTitleLabel.textColor = TTOrange
        toDoTitleLabel.font = UIFont(name: TTDefaultFontName, size: 17.0)
    }
    
    func configureDateAddedLabel() {
        dateAddedLabel.font = UIFont(name: TTDefaultFontName, size: 12.0)
        dateAddedLabel.textColor = UIColor.lightGrayColor()
    }
    
    func configureWithToDo(toDo:Todo) {
        toDoTitleLabel.text = toDo.title ?? ""
        var displayCheckMark = false
        if let completed = toDo.completed?.boolValue {
            displayCheckMark = completed
        }
        let localizedDate = NSDateFormatter.localizedStringFromDate(toDo.createdAt!, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
        dateAddedLabel.text = "Created \(localizedDate)"
        accessoryType = displayCheckMark ? .Checkmark : .None
        
    }
}
