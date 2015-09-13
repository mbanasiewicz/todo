//
//  TTDefines.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit

let TTErrorDomain = "pl.koalapps.error"
let TTDefaultFontName = "Avenir-Book"
let TTOrange = rgba(255, green: 87, blue: 34,alpha: 1.0)
let TTBarTintColor = rgba(207.0, green: 216.0, blue: 220.0, alpha: 1.0)
let TTTableViewBackgroundColor = rgba(245.0, green: 245.0, blue: 245.0, alpha: 1.0)

func rgba(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

extension UITableView {
    // Utility to save space in root vc
    @IBAction func toggleEditing() {
        setEditing(!editing, animated: true)
    }
}

// Enum to avoid typeos
enum ToDoStoryboardIdentifiers:String {
    case AddNewEntry = "AddNewEntry"
    case Root = "Root"
}

extension UIViewController {
    func presentErrorAlert(errorReason:String) {
        let alertController = UIAlertController(title: "An error occured", message: errorReason, preferredStyle: UIAlertControllerStyle.Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    // Loads view from nib, if none found returns nil
    class func loadViewFromNib() -> UIView? {
        let className = NSStringFromClass(self).componentsSeparatedByString(".").last
        guard className != nil else { return nil }
        
        let nibObjects = NSBundle.mainBundle().loadNibNamed(className!, owner: nil, options: nil)
        
        guard nibObjects.count > 0 else { return nil }
        
        for object in nibObjects {
            if object is UIView {
                return object as? UIView
            }
        }
        return nil
    }
}