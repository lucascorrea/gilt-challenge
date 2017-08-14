//
//  GiltTestCase.swift
//  GiltTestCase
//
//  Created by Lucas Correa on 13/08/2017.
//  Copyright © 2017 SiriusCode. All rights reserved.
//

import XCTest

class GiltTestCase: XCTestCase {
    
    //
    // MARK: - Invalid Tests
    func testBadFinish() {
        try? checkTestInvalidNamed("invalid1", expectedResult: Errors.invalidFinish)
    }
    
    func testInvalidColor() {
        try? checkTestInvalidNamed("invalid2", expectedResult: Errors.invalidColorPreferences)
    }
    
    func testMissingNumberOfColors() {
        try? checkTestInvalidNamed("invalid3", expectedResult: Errors.numberOfColorsNotProvided)
    }
    
    func testInvalidNumberOfColors() {
        try? checkTestInvalidNamed("invalid4", expectedResult: Errors.invalidFileFormat)
    }
    
    //
    // MARK: - Valid Tests
    func testValid1() {
        checkTestNamed("valid1", expectedResult: "G G G G M")
    }
    
    func testValid2() {
        checkTestNamed("valid2", expectedResult: Constants.NoSolutionExists)
    }
    
    func testValid3() {
        checkTestNamed("valid3", expectedResult: "M M")
    }
    
    func testValid4() {
        checkTestNamed("valid4", expectedResult: "M M")
    }
    
    func testValid5() {
        checkTestNamed("valid5", expectedResult: "G G G M G")
    }
    
    func testValid6() {
        checkTestNamed("valid6", expectedResult: "G M G M G")
    }
    
    func testValid7() {
        checkTestNamed("valid7", expectedResult: "G G G G M")
    }
    
    
    //
    // MARK: - Private Functions
    fileprivate func checkTestNamed(_ name: String, expectedResult: String) {
        let inputFileReader = InputFileReader()
        
        guard let string = try? inputFileReader.readFileAt(name) else {
            XCTFail()
            return
        }
        
        guard let paintShop = try? PaintShop(string: string) else {
            XCTFail()
            return
        }
        
        let manager = ManagerPaint(paintShop: paintShop)
        let result = manager.mixColors()
        
        XCTAssertEqual(result, expectedResult)
    }
    
    fileprivate func checkTestInvalidNamed(_ name: String, expectedResult: Errors) throws {
        let inputFileReader = InputFileReader()
        
        guard let string = try? inputFileReader.readFileAt(name) else {
            XCTFail()
            return
        }
        
        XCTAssertThrowsError(try PaintShop(string: string)) { error in
            print(error)
            XCTAssertEqual(error as? Errors, expectedResult)
        }
    }
    
}
