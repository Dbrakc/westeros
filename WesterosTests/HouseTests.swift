//
//  HouseTest.swift
//  WesterosTests
//
//  Created by David Braga  on 6/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    var starkSigil : Sigil!
    var lannisterSigil : Sigil!
    
    var stark : House!
    var lannister : House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    

    override func setUp() {
        starkSigil = Sigil (image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")
        
        stark = House(name: "Stark", sigil: starkSigil, words:"Se acerca el invierno")
        lannister = House(name: "lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        robb = Person(name: "Robb", alias: "El joven Lobo", house: stark)
        arya = Person(name: "Arya", house: stark)
        
        tyrion = Person(name: "Tyrion", alias: "el enano", house: lannister)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHouseExistence (){
        XCTAssertNotNil(stark)
    }
    
    func testSigilExistence (){
        XCTAssertNotNil( starkSigil )
        XCTAssertNotNil(lannisterSigil)
    }
    
    //Give - When -Then
    func testHouse_AddPersons_ReturnsTheCorrectCountOfPersons(){
        XCTAssertEqual(stark.count,0)
        stark.add(person: robb)
        stark.add(person: robb)
        stark.add(person: robb)
        XCTAssertEqual(stark.count,1)
        
        stark.add(person: arya)
        XCTAssertEqual(stark.count,2)
        
        XCTAssertEqual(lannister.count, 0)
        lannister.add(person: tyrion)
        XCTAssertEqual(lannister.count, 1)
        
        stark.add(person: tyrion)
        XCTAssertEqual(stark.count,2)
        
    }
    
    func testHouseEquality(){
        //Identidad
        XCTAssertEqual(stark, stark)
        //Igualdad
        let jinxed: House! = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        XCTAssertEqual(stark, jinxed)
        //Desiguald
        XCTAssertNotEqual(stark, lannister)
    }
    
    func testHouseHashable(){
        XCTAssertNotNil(stark.hashValue)
    }
    
    func testHouseComparison(){
        XCTAssertLessThan(lannister, stark)
    }

}
