//
//  MastermindTests.swift
//  MastermindTests
//
//  Created by Ramcharan Reddy Gaddam on 10/08/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import XCTest
@testable import Mastermind

class MastermindTests: XCTestCase {
    
    var sut: ViewController?
    
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(identifier: "home") as? ViewController
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testRandomStringGeneration() {
        let generatedWord = String.generateRandomWord(ofLength: 4)
        XCTAssert(generatedWord.count == 4)
    }
    
    func testRandomStringGeneratedOnLoad() {
        let _ = sut?.view
        let generatedWord = sut!.randomString
        XCTAssert(generatedWord!.count == 4)
    }
    
    func testCheckActionOnSuccessCase() {
        let _ = sut?.view
        sut?.letter1input.text = "a"
        sut?.letter2input.text = "b"
        sut?.letter3input.text = "c"
        sut?.letter4input.text = "d"
        sut?.checkAction(sut!.checkButton!)
        XCTAssert((sut?.validationStatusLabel.isHidden)!)
        XCTAssert((sut?.checkButton.isSelected)!)
    }
    
    func testCheckActionOnValidationError() {
        let _ = sut?.view
        // inputs
        sut?.letter1input.text = "a"
        sut?.letter2input.text = "b"
        sut?.letter3input.text = "c"
        //action
        sut?.checkAction(sut!.checkButton!)
        //assertion
        XCTAssert(!(sut?.validationStatusLabel.isHidden)!)
    }
    
    func testReplayAction() {
        let _ = sut?.view
        sut?.checkButton.isSelected = true
        sut?.replayAction()
        XCTAssert((sut?.validationStatusLabel.isHidden)!)
        XCTAssert(!(sut?.checkButton.isSelected)!)
        XCTAssert((sut?.letter1input.text!.isEmpty)!)
        XCTAssert((sut?.letter2input.text!.isEmpty)!)
        XCTAssert((sut?.letter3input.text!.isEmpty)!)
        XCTAssert((sut?.letter4input.text!.isEmpty)!)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
