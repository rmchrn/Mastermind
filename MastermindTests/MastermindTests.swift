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
        let generatedWord = String.generateRandomWord(from: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", ofLength: 4)
        XCTAssert(generatedWord.count == 4)
    }
    
    func testRandomStringGeneratedOnLoad() {
        let _ = sut?.view
        let generatedWord = sut!.randomString
        XCTAssert(generatedWord!.count == 4)
    }
    
    func testCheckActionOnSuccessCase() {
        let _ = sut?.view
        sut?.letterInputs[0].text = "a"
        sut?.letterInputs[1].text = "b"
        sut?.letterInputs[2].text = "c"
        sut?.letterInputs[3].text = "d"
        sut?.checkAction(sut!.checkButton!)
        XCTAssert((sut?.validationStatusLabel.isHidden)!)
        XCTAssert((sut?.checkButton.isSelected)!)
    }
    
    func testCheckActionOnValidationError() {
        let _ = sut?.view
        // inputs
        sut?.letterInputs[0].text = "a"
        sut?.letterInputs[1].text = "b"
        sut?.letterInputs[2].text = "c"
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
        XCTAssert((sut?.letterInputs[0].text!.isEmpty)!)
        XCTAssert((sut?.letterInputs[1].text!.isEmpty)!)
        XCTAssert((sut?.letterInputs[2].text!.isEmpty)!)
        XCTAssert((sut?.letterInputs[3].text!.isEmpty)!)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
