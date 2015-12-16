//
//  CopyableLabel.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/16/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

import UIKit

protocol EditedLabelDelegate: class {
    func valueWasPastedInsideLabel(value:String)
}

class CopyableLabel: UILabel {
    
    weak var editDelegate:EditedLabelDelegate?
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == Selector("paste:") || action == Selector("copy:") {
            return true
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() {
            self.highlighted = true
            return true
        }
        return false
    }
    
    override func copy(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        board.string = self.text
        self.highlighted = false
        self.resignFirstResponder()
    }
    
    override func paste(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        if let string = board.string {
            if string != "" && Int(string) != nil {
                self.text = string
                if let editDel = editDelegate {
                    editDel.valueWasPastedInsideLabel(string)
                }
            }
        }
        self.highlighted = false
        self.resignFirstResponder()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.isFirstResponder() == true {
            self.highlighted = false
            let menu = UIMenuController.sharedMenuController()
            menu.setMenuVisible(false,animated: true)
            menu.update()
            self.resignFirstResponder()
        } else if self.becomeFirstResponder() == true {
            let menu = UIMenuController.sharedMenuController()
            menu.setTargetRect(self.bounds, inView: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
}

