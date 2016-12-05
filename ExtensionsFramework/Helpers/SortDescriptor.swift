//
//  SortDescriptor.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/12/2016.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//  I've added this sortdescriptor builder class in order to avoid runtime issues that might occur using the NSSortDescriptor API (no type safety for key values or selectors). 

import Foundation

public typealias SortDescriptor<A> = (A, A) -> Bool

public class SortDescriptorBuilder {
    
    public static func sortDescriptor<Value, Property>(ascending: Bool = true, property: @escaping (Value) -> Property, comparator: @escaping (Property) -> (Property) -> ComparisonResult) -> SortDescriptor<Value> {
        return { value1, value2 in
            let comparisonResult: ComparisonResult = ascending ? .orderedAscending : .orderedDescending
            return comparator(property(value1))(property(value2)) == comparisonResult
        }
    }
    
    public static func sortDescriptor<Value, Property>(ascending: Bool = true, property: @escaping (Value) -> Property) -> SortDescriptor<Value> where Property: Comparable {
        return { value1, value2 in
            ascending ? property(value1) < property(value2) : property(value1) > property(value2)
        }
    }
    
    public static func combine<A>(sortDescriptors: [SortDescriptor<A>]) -> SortDescriptor<A> {
        return { value1, value2 in
            for descriptor in sortDescriptors {
                if descriptor(value1, value2) { return true }
                if descriptor(value2, value1) { return false }
            }
            return false
        }
    }
    
}
