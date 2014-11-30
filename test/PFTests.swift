//
//  PFTests.swift
//  PFTests
//
//  Created by M. David Minnigerode on 11/28/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import UIKit
import XCTest

class PFTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
//        // This is an example of a functional test case.
//        
//        let pf = PluralForms.pluraCategory(NSLocale(localeIdentifier: "en_US"), n:1)
//        println("PF is: \(pf?.rawValue)")
//        
//        XCTAssertTrue(pf == .one, "Should be one form")
    
    }
    
    
    func testApples(){
        
       // println(NSLocale.autoupdatingCurrentLocale().localeIdentifier)
        
        let us = NSLocale(localeIdentifier:"en_US")
        let k = "apples"
        println(self.doIt(k, count: 0, loc: us))
        println(self.doIt(k, count: 1, loc: us))
        println(self.doIt(k, count: 2, loc: us))
        
        
//        Russian	ru	one	1, 21, 31, 41, 51, 61...	one → n mod 10 is 1 and n mod 100 is not 11;
//        few → n mod 10 in 2..4 and n mod 100 not in 12..14;
//        many → n mod 10 is 0 or n mod 10 in 5..9 or n mod 100 in 11..14;
//        other → everything else
        let ru = NSLocale(localeIdentifier: "ru")
        println(self.doIt(k, count: 0, loc: ru))
        println(self.doIt(k, count: 1, loc: ru))
        println(self.doIt(k, count: 22, loc: ru))
        println(self.doIt(k, count: 111, loc: ru))
        
    }
    
    func doIt(key:String, count:Int, loc:NSLocale) -> String {
        var a = PluralizedStrings.pluralize(key, numberValue: count, locale: loc)
        return "\(count) -> \(a)"
    }
    
    
    func testLoc(){
        var x = NSLocalizedString("key1", value: "A value", comment: "A comment")
        println("Got value of: \(x)")
        
        let uuid = NSUUID()
        x = NSLocalizedString("keyNone", value: uuid.UUIDString, comment: "A comment")
        println("Got value of: \(x)")
        
        x = NSLocalizedString("keyNone", comment: "A comment")
        println("Got value of: \(x)")

    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
