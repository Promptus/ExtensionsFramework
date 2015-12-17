//
//  XCTAssertMacroExtension.h
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 05.11.13.
//  Copyright (c) 2013 Promptus. All rights reserved.
//

#define XCTAssertEqualStrings(a1, a2) XCTAssertTrue([a1 isEqualToString:a2], @"%@ should equal %@", a1, a2)
