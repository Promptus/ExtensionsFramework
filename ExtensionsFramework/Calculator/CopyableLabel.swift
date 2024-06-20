//
//  CopyableLabel.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/16/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

import UIKit

protocol EditedLabelDelegate: AnyObject {
    func valueWasPastedInsideLabel(_ value:String)
}

class CopyableLabel: UILabel {
    
    weak var editDelegate:EditedLabelDelegate?
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() {
            self.isHighlighted = true
            return true
        }
        return false
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = self.text
        self.isHighlighted = false
        self.resignFirstResponder()
    }
    
    override func paste(_ sender: Any?) {
        let board = UIPasteboard.general
        if let string = board.string {
            if string != "" && Int(string) != nil {
                self.text = string
                if let editDel = editDelegate {
                    editDel.valueWasPastedInsideLabel(string)
                }
            }
        }
        self.isHighlighted = false
        self.resignFirstResponder()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isFirstResponder == true {
            self.isHighlighted = false
            let menu = UIMenuController.shared
            menu.setMenuVisible(false,animated: true)
            menu.update()
            self.resignFirstResponder()
        } else if self.becomeFirstResponder() == true {
            let menu = UIMenuController.shared
            menu.setTargetRect(self.bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
}

