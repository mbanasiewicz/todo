//
//  ToDoDetailView.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 13/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

class ToDoDetailView: UIView {
    @IBOutlet weak var toDoTileLabel: UILabel!
    @IBOutlet weak var toDoNoteLabel: UILabel!
    
    override func awakeFromNib() {
        toDoTileLabel.font = UIFont(name: TTDefaultFontName, size: 20.0)
        toDoTileLabel.textColor = TTOrange
        
        toDoNoteLabel.font = UIFont(name: TTDefaultFontName, size: 15.0)
        toDoNoteLabel.textColor = UIColor.lightGrayColor()
    }
}
