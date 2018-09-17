//
//  RepositoriesTest.swift
//  WesterosTests
//
//  Created by David Braga  on 12/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import XCTest
@testable import Westeros
class RepositoriesTest: XCTestCase {
    var localHouses: [House]!

    override func setUp() {
        localHouses = Repository.local.houses
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLocalRepositoryExistence(){
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHousesCreation(){
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoreReturnSortedArrayOfHouses(){
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsetively(){
        let stark = Repository.local.house(named: "sTaRk")
        
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named:"keepcoding")
        XCTAssertNil(keepcoding)

    }
    
    func testHouseLocalRepositoryHouseFiltering(){
        let filtered = Repository.local.houses{$0.count == 1}
        
        XCTAssertEqual(filtered.first?.name, "Targaryen")
        
        
        let filtered0 = Repository.local.houses{$0.count == 0}
        XCTAssertTrue(filtered0.isEmpty)
        
    }



}
