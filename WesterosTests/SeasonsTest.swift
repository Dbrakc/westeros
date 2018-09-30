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
    var date: Date!
    var anotherDate: Date!
    var episode: Episode!
    var episode2: Episode!
    var season: Season!
    var seasonEqualSeason: Season!
    var seasonDifferentName: Season!
    var seasonDifferentDate: Season!

    override func setUp() {
        date = Date.dateWithDay(29, month: 12, year: 1985)
        anotherDate  = Date.dateWithDay(5, month: 6, year: 2015)
        episode = Episode(withTitle: "Episode 1", issueDate: date, resume: Constants.resumeS7E2)
        episode2 = Episode(withTitle: "Episode 2", issueDate: anotherDate, resume: Constants.resumeS7E2)
        season = Season (withName: "Season 1", episodeArray: [episode])
        seasonEqualSeason = Season (withName: "Season 1", episodeArray: [episode])
        seasonDifferentName = Season (withName: "Season 0", episodeArray: [episode])
        seasonDifferentDate = Season (withName: "Season 1", episodeArray: [episode2])
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonsExistence (){
        let seasonsWithEmptyEpisode = Season (withName: "Season 1", episodeArray: [])
        
        XCTAssertNotNil(season!)
        XCTAssertNil(seasonsWithEmptyEpisode)
    }
    
    func testSeason_Description_ReturnsRightString(){
        let response = "NAME: SEASON 1, RELEASE DATE: 1985-12-29, COUNT OF EPISODES: 1"
        XCTAssertEqual(response.uppercased(),season.description.uppercased())
        
    }
    
    func testSeason_EqualsAnotherSeason_ResturnsRightBoolean(){
        //Identity
        XCTAssertEqual(season, season)
        //Equality
        XCTAssertEqual(season, seasonEqualSeason)
        //Distinct name
        XCTAssertNotEqual(season, seasonDifferentDate)
        //Distinc date
        XCTAssertNotEqual(season, seasonDifferentName)
        
    }
    
    func testSeason_HashValue_ReturnsNotNil (){
        XCTAssertNotNil(season.hashValue)
    }
    
    func testSeason_Compare_ReturnsCorrectBool (){
        XCTAssertGreaterThan(seasonDifferentDate, season)
        XCTAssertGreaterThan(season, seasonDifferentName)
    }
    
    

}


