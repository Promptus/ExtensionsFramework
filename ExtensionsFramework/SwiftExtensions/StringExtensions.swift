//
//  StringExtensions.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/11/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

import Foundation

public extension String {
    
    public func filter(_ predicate: (Character) -> Bool) -> String {
        var result = String()
        for character in self {
            if predicate(character) {
                result.append(character)
            }
        }
        return result
    }
    
}

