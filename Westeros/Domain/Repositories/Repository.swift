//
//  Repository.swift
//  Westeros
//
//  Created by David Braga  on 12/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

//Te abstrae de donde vienen los datos
final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House]{get}
    
    func house (named: String)->House?
    
    func houses (filteredBy filter: Filter)->[House]
}


//Cuando necesitamos crear muchos objetos del mismo tipo
final class LocalFactory: HouseFactory{
    
    var houses : [House]{
        //Houses creation here
        
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!,description: "Lobo Guargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!,description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón tricéfalo")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oyer mi rugido", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y sangre", url: URL.init(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        //Characters creation
        let robb = Person (name: "Robb", alias: "El Joven Lobo", house:starkHouse)
        let arya = Person (name: "Arya", house: starkHouse)
        let tyrion = Person (name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person (name: "Cersei", house: lannisterHouse)
        let jaime = Person (name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person (name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        //add characters to house
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(person: dani)
        
        return [starkHouse,lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return Repository.local.houses.filter{ $0.name.uppercased() == name.uppercased() }.first
    }
    
    func houses(filteredBy: (House) -> Bool) -> [House] {
        return houses.filter(filteredBy)
    }
    
    
    
}
