//
//  SeasonsTest.swift
//  WesterosTests
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonsTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonsExistence (){
        let date: Date! = Date.dateWithDay(29, month: 12, year: 1985)
        
        let season = Season (withName: "Season 1", date: date, episodesList: ["episode"])
        
        let seasonsWithEmptyEpisode = Season (withName: "Season 1", date: date, episodesList: [])
       
        
        XCTAssertNotNil(season!)
        XCTAssertNil(seasonsWithEmptyEpisode)
    }

}


