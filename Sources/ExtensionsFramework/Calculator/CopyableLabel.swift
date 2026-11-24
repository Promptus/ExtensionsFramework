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
            if #available(iOS 16.0, *) {
                interactions.compactMap { $0 as? UIEditMenuInteraction }.first?.dismissMenu()
            } else {
                UIMenuController.shared.hideMenu(from: self)
            }
            self.resignFirstResponder()
        } else if self.becomeFirstResponder() == true {
            if #available(iOS 16.0, *) {
                let menu: UIEditMenuInteraction
                if let existing = interactions.compactMap({ $0 as? UIEditMenuInteraction }).first {
                    menu = existing
                } else {
                    menu = UIEditMenuInteraction(delegate: self)
                    addInteraction(menu)
                }
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                menu.presentEditMenu(with: UIEditMenuConfiguration(identifier: nil, sourcePoint: center))
            } else {
                UIMenuController.shared.showMenu(from: self, rect: bounds)
            }
        }
    }
    
}

@available(iOS 16.0, *)
extension CopyableLabel: UIEditMenuInteractionDelegate {}

