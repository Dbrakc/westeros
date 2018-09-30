//
//  Repository.swift
//  Westeros
//
//  Created by David Braga  on 12/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    
    var houses: [House]{get}
    
    func house (named: String)->House?
    
    func house(named houseName: HouseName ) -> House?
    
    func houses (filteredBy filter: HouseFilter)->[House]
}

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    
    var seasons : [Season] {get}
    
    func seasons (filteredBy filter: SeasonFilter) ->[Season]
    
    func setEpisodesSeason(season: Season)
}


final class LocalFactory: HouseFactory{
    var houses : [House]{
        //Houses creation here
        
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!,description: "Lobo Guargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!,description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón tricéfalo")
        
        let starkHouse = House(name: .stark , sigil: starkSigil, words: "Se acerca el invierno", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: .lannister, sigil: lannisterSigil, words: "Oyer mi rugido", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: .targaryen, sigil: targaryenSigil, words: "Fuego y sangre", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        //Characters creation
        Person.createMemberInHouse(withName: "Robb", alias: "El Joven Lobo", house:starkHouse)
        Person.createMemberInHouse(withName: "Arya", house: starkHouse)
        Person.createMemberInHouse(withName: "Tyrion", alias: "El enano", house: lannisterHouse)
        Person.createMemberInHouse(withName: "Cersei", house: lannisterHouse)
        Person.createMemberInHouse(withName: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        Person.createMemberInHouse(withName: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)

        
        return [starkHouse,lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return Repository.local.houses.filter{ $0.name.uppercased() == name.uppercased() }.first
    }
    
    func house(named houseName: HouseName ) -> House?{
        return Repository.local.houses.filter{ $0.name.uppercased() == houseName.rawValue.uppercased() }.first
    }
    
    func houses(filteredBy: (House) -> Bool) -> [House] {
        return houses.filter(filteredBy)
    }
    
    
    
}

extension LocalFactory : SeasonFactory{
    
    var seasons : [Season] {
        let dateS1E1 = Date.dateWithDay(17, month: 04, year: 2011)
        let dateS1E2 = Date.dateWithDay(24, month: 04, year: 2011)
        let dateS2E1 = Date.dateWithDay(01, month: 04, year: 2012)
        let dateS2E2 = Date.dateWithDay(08, month: 04, year: 2012)
        let dateS3E1 = Date.dateWithDay(31, month: 03, year: 2013)
        let dateS3E2 = Date.dateWithDay(07, month: 04, year: 2013)
        let dateS4E1 = Date.dateWithDay(06, month: 04, year: 2014)
        let dateS4E2 = Date.dateWithDay(13, month: 04, year: 2014)
        let dateS5E1 = Date.dateWithDay(12, month: 04, year: 2015)
        let dateS5E2 = Date.dateWithDay(19, month: 04, year: 2015)
        let dateS6E1 = Date.dateWithDay(24, month: 04, year: 2016)
        let dateS6E2 = Date.dateWithDay(01, month: 05, year: 2016)
        let dateS7E1 = Date.dateWithDay(16, month: 07, year: 2017)
        let dateS7E2 = Date.dateWithDay(23, month: 07, year: 2017)
        
        
        let episodeS1E1 = Episode (withTitle: "Winter is comming", issueDate: dateS1E1!, resume: Constants.resumeS1E1 )
        let episodeS1E2 = Episode (withTitle: "The Kingsroad", issueDate: dateS1E2!, resume: Constants.resumeS1E2)
        let episodeS2E1 = Episode (withTitle: "The north remembers", issueDate: dateS2E1!, resume: Constants.resumeS2E1)
        let episodeS2E2 = Episode (withTitle: "The night lands", issueDate: dateS2E2!, resume: Constants.resumeS2E2)
        let episodeS3E1 = Episode (withTitle: "Valar Dohaeris" , issueDate: dateS3E1!, resume: Constants.resumeS3E1)
        let episodeS3E2 = Episode (withTitle: "Dark wings, dark words", issueDate: dateS3E2!, resume: Constants.resumeS3E2)
        let episodeS4E1 = Episode (withTitle: "Two swords", issueDate: dateS4E1!, resume: Constants.resumeS4E1)
        let episodeS4E2 = Episode (withTitle: "The lion and the rose", issueDate: dateS4E2!, resume: Constants.resumeS4E2)
        let episodeS5E1 = Episode (withTitle: "The wars to come", issueDate: dateS5E1!, resume: Constants.resumeS5E1)
        let episodeS5E2 = Episode (withTitle: "The house of black and White", issueDate: dateS5E2!, resume: Constants.resumeS5E2)
        let episodeS6E1 = Episode (withTitle: "The red woman", issueDate: dateS6E1!, resume: Constants.resumeS6E1)
        let episodeS6E2 = Episode (withTitle: "Home", issueDate: dateS6E2!, resume: Constants.resumeS6E2)
        let episodeS7E1 = Episode (withTitle: "Dragonston", issueDate: dateS7E1!, resume: Constants.resumeS7E1)
        let episodeS7E2 = Episode (withTitle: "Stormborn", issueDate: dateS7E2!, resume: Constants.resumeS7E2)
        
        
        
        let season1 = Season(withName: "Season 1", episodeArray: [episodeS1E1, episodeS1E2])
        let season2 = Season(withName: "Season 2", episodeArray: [episodeS2E1, episodeS2E2])
        let season3 = Season(withName: "Season 3", episodeArray: [episodeS3E1, episodeS3E2])
        let season4 = Season(withName: "Season 4", episodeArray: [episodeS4E1, episodeS4E2])
        let season5 = Season(withName: "Season 5", episodeArray: [episodeS5E1, episodeS5E2])
        let season6 = Season(withName: "Season 6", episodeArray: [episodeS6E1, episodeS6E2])
        let season7 = Season(withName: "Season 7", episodeArray: [episodeS7E1, episodeS7E2])
        
        
        let seasons = [season1!, season2!, season3!, season4!, season5!, season6!, season7!].sorted()
        
        seasons.forEach{setEpisodesSeason(season: $0)}
        
        return seasons
    }
    
    
    
    func seasons(filteredBy filter: (Season) -> Bool) -> [Season] {
        return seasons.filter(filter)
    }
    
    func setEpisodesSeason(season: Season){
       season.episodesSorted.forEach{$0.season = season}
    }
    
    
}
