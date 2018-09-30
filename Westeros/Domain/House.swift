//
//  House.swift
//  Westeros
//
//  Created by David Braga  on 6/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiUrl: URL
    private var _members: Members
    
    var sortedMember: [Person]{
        return _members.sorted()
    }
    
    init(name: String, sigil: Sigil, words: Words, url: URL){
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiUrl = url
        self._members = Members()
    }
    
    init(name: HouseName, sigil: Sigil, words: Words, url: URL){
        self.name = name.rawValue
        self.sigil = sigil
        self.words = words
        self.wikiUrl = url
        self._members = Members()
        
    }
}

extension House{
    var count: Int {
        return _members.count
    }
    
    func add(person: Person){
        guard person.house == self else{
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...){
        persons.forEach{add(person: $0)}
    }
    
}

extension House{
    var proxyForEquality : String {
        return "\(name)\(words)\(count)"
    }
    var proxyForComparison: String{
        return name.lowercased()
    }
}

extension House : Equatable{
    static func == (lhs:House, rhs:House)->Bool{
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House : Hashable{
    var hashValue : Int{
        return proxyForEquality.hashValue
    }
}

extension House : Comparable{
    static func < (lhs: House, rhs: House) -> Bool {
        //Oden alphabetico
        return lhs.proxyForComparison<rhs.proxyForComparison
    }
}
