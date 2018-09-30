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
    var localSeasons: [Season]!

    override func setUp() {
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
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
    
    func testLocalRepositoryReturnsHousesByHouseName(){
        let stark = Repository.local.house(named: .stark)
        
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

extension RepositoriesTest{
    
    func testLocalRepositorySeasonsCreation(){
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
        let season3 = localSeasons[2]
        let episodeS3E2 = season3.episodesSorted[1]
        XCTAssertEqual(season3, episodeS3E2.season )
    }
    
    func testSeasonsLocalRepositoryHouseFiltering(){
        let filtered = Repository.local.seasons{ $0.releaseDate < Date.dateWithDay(01, month: 01, year: 2012)!}
        
        XCTAssertEqual(filtered.first?.name, "Season 1")
        
        
        let filtered0 = Repository.local.houses{$0.count == 0}
        XCTAssertTrue(filtered0.isEmpty)
        
    }
    
    func testSeasonsLocalRepo_setEpisodeSeasons_returnEpisodeWithSeason(){
        Repository.local.setEpisodesSeason(season: localSeasons[3])
    XCTAssertEqual(localSeasons[3],localSeasons[3].episodesSorted[1].season )
        
    }
    
    



}
