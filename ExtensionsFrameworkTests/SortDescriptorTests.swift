//
//  SortDescriptorTests.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/12/2016.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//

import XCTest

class SortDescriptorTests: XCTestCase {
    
    fileprivate struct Person {
        let firstName: String
        let lastName: String
        let yearOfBirth: Int
        let registeredDate: Date
    }
    
    fileprivate var people = [
        Person(firstName: "Jo", lastName: "Smith", yearOfBirth: 1970, registeredDate: Date()),
        Person(firstName: "Joanne", lastName: "Williams", yearOfBirth: 1985, registeredDate: Date()),
        Person(firstName: "Annie", lastName: "Williams", yearOfBirth: 1985, registeredDate: Date()),
        Person(firstName: "Robert", lastName: "Jones", yearOfBirth: 1990, registeredDate: Date()),
    ]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSortDescriptor() {
        let firstName: SortDescriptor<Person> = SortDescriptorBuilder.sortDescriptor(property: { $0.firstName }, comparator: String.localizedCaseInsensitiveCompare)
        let lastName: SortDescriptor<Person> = SortDescriptorBuilder.sortDescriptor(property: { $0.lastName }, comparator: String.localizedCaseInsensitiveCompare)
        let yearOfBirth: SortDescriptor<Person> = SortDescriptorBuilder.sortDescriptor(ascending: false, property: { $0.yearOfBirth })
        
        let sortedPeople = people.sorted(by: SortDescriptorBuilder.combine(sortDescriptors: [firstName, lastName, yearOfBirth]))
        let sortedResult = [
            Person(firstName: "Annie", lastName: "Williams", yearOfBirth: 1985, registeredDate: Date()),
            Person(firstName: "Jo", lastName: "Smith", yearOfBirth: 1970, registeredDate: Date()),
            Person(firstName: "Joanne", lastName: "Williams", yearOfBirth: 1985, registeredDate: Date()),
            Person(firstName: "Robert", lastName: "Jones", yearOfBirth: 1990, registeredDate: Date()),
            ]
        
        XCTAssertEqual(sortedPeople[2].firstName, sortedResult[2].firstName, "sorted arrays")
    }
    
}
