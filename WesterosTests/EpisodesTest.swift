//
//  EpisodesTest.swift
//  WesterosTests
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodesTest: XCTestCase {
    var date: Date!
    var date99 : Date!
    var episode : Episode!
    var episode2 : Episode!
    var episode3 : Episode!
    var episode4 : Episode!

    override func setUp() {
        date = Date.dateWithDay(29, month: 12, year: 1985)
        episode = Episode(withTitle: "Episode 1", issueDate: date)
        date99 = Date.dateWithDay(1, month: 6, year: 1999)
        episode2 = Episode(withTitle: "Episode 1", issueDate: date)
        episode3 = Episode(withTitle: "Episode 0", issueDate: date)
        episode4 = Episode(withTitle: "Episode 1", issueDate: date99)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence (){
        
        XCTAssertNotNil(episode)
    }
    
    func testEpisode_Description_ReturnsRightString(){
        let response = "TITLE: EPISODE 1, ISSUEDATE: 1985-12-29"
        XCTAssertEqual(response.uppercased(),episode.description.uppercased())
        let season = Season (withName: "Season 1", episodeArray: [episode])
        episode.season = season
        let responseWithSeason = response + ", SEASON: SEASON 1"
        XCTAssertEqual(responseWithSeason.uppercased(), episode.description.uppercased())
    }
    
    func testEpisode_EqualsAnotherEpisode_ResturnsRightBoolean(){
        //Identity
        XCTAssertEqual(episode, episode)
        //Equality
        XCTAssertEqual(episode, episode2)
        //Distinct name
        XCTAssertNotEqual(episode, episode3)
        //Distinc date
        XCTAssertNotEqual(episode, episode4)
        
    }
    
    func testEpisode_HashValue_ReturnsNotNil (){
        XCTAssertNotNil(episode.hashValue)
    }
    
    func testEpisode_Compare_ReturnsCorrectBool (){
        XCTAssertGreaterThan(episode4, episode)
        XCTAssertGreaterThan(episode, episode3)
    }

}
