//
//  CharacterTest.swift
//  WesterosTests
//
//  Created by David Braga  on 6/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    
    var starkHouse : House!
    var starkSigil : Sigil!
    var ned : Person!
    var arya : Person!

    override func setUp() {
        starkSigil = Sigil (image: UIImage(), description: "Lobo Huargo")
        starkHouse = House (name: "Stark", sigil: starkSigil, words: "se acerca el invierno", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        ned = Person (name: "Eddard", alias: "Ned", house: starkHouse )
        arya = Person (name: "Arya", house: starkHouse);
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence (){
        
        XCTAssertNotNil(ned)
        
        
        XCTAssertNotNil(arya)
    }
    
    func testPersonFullName (){
        XCTAssertEqual(ned.fullName, "Eddard Stark")
        XCTAssertEqual(arya.fullName, "Arya Stark")
    }
    
    func testPersonEquality(){
        //1.Identidad
        XCTAssertEqual(ned, ned)
        //2.Igualdad
        let eddard = Person(name: "Eddard",alias:"Ned",house:starkHouse)
        XCTAssertEqual(eddard, ned)
        //3. desigualdad
        XCTAssertNotEqual(ned, arya)
    }
    
    func testPersonComparison(){
        XCTAssertGreaterThan(ned, arya)
    }
    
    func testPerson_CreateMemberInHouse_ReturnsAMemberInHouse(){
        Person.createMemberInHouse(withName: "member1", house: starkHouse)
        Person.createMemberInHouse(withName: "member2", alias: "alias2", house: starkHouse)
        
        starkHouse.sortedMember.forEach{XCTAssertEqual(starkHouse,$0.house)}
        XCTAssertEqual(2, starkHouse.sortedMember.count)
    }
    
    
    
    
    

  

}
