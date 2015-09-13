//
//  ToDoDetailView.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

class ToDoDetailViewController: UIViewController {
    var toDo:Todo
    
    init(toDo:Todo) {
        self.toDo = toDo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None
        configureViewWithToDo()
        title = "ToDo"
    }
    
    // p stands for private
    private func pview() -> ToDoDetailView {
        return view as! ToDoDetailView
    }
    
    func configureViewWithToDo() {
        pview().toDoTileLabel.text = toDo.title!
        pview().toDoNoteLabel.text = toDo.notes ?? ""
    }
}
