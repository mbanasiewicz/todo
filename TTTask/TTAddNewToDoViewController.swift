//
//  TTAddNewToDoViewController.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

class TTAddNewToDoViewController: UITableViewController, UITextViewDelegate {
    var coreDataStack:TTCoreDataStack?
    
    var currentTitle:String? {
        didSet {
          updateSaveButtonAvailability()
        }
    }
    var currentNote:String?
    
    // MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Utilities
    func configureTableView() {
        tableView.registerNib(UINib(nibName: TTTextFieldCellRI, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: TTTextFieldCellRI)
        tableView.registerNib(UINib(nibName: TTTextViewCellRI, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: TTTextViewCellRI)
    }
    
    func updateSaveButtonAvailability() {
        if let currentTitle = self.currentTitle {
            navigationItem.rightBarButtonItem?.enabled = currentTitle.utf8.count > 0
        }
    }
    
    // MARK: Events
    func textViewDidChange(textView: UITextView) {
        currentNote = textView.text
    }
    
    func titleTextFieldChanged(textField:UITextField) {
        currentTitle = textField.text
    }
    
    // MARK: Actions
    @IBAction func saveNewItem() {
        if let moc = coreDataStack?.mainManagedObjectContext {
            Todo.createInContext(moc, title: self.currentTitle!, notes: self.currentNote ?? "")
            do {
                try moc.save()
            } catch {
                presentErrorAlert("Unable to save, please try again")
            }
        }
        dismiss()
    }
    
    @IBAction func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Table view
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(TTTextFieldCellRI) as! TTTextFieldCell
            cell.textField.addTarget(self, action: Selector("titleTextFieldChanged:"), forControlEvents: UIControlEvents.EditingChanged)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TTTextViewCellRI) as! TTTextViewCell
        cell.textView.delegate = self
        return cell
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Title"
        }
        
        return "Notes"
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 200.0
        } else {
            return 44.0
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
