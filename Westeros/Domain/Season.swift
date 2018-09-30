//
//  Season.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>
final class Season{
  // TODO: Make a set of episodes
    let name: String
    private let _episodes: Episodes
    var episodesCount: Int {
        return self._episodes.count
    }
    var episodesSorted : [Episode]{
        return _episodes.sorted()
    }
    var releaseDate : Date {
        return episodesSorted.first!.issueDate
    }
    
    init?(withName name: String, episodeArray episodes: [Episode]){
        self.name = name
        guard  !episodes.isEmpty else{return nil}
        
        self._episodes = Episodes(episodes)
    }
    
    
    
}

extension Season {
    var proxyForEquality : String {
        return "\(self.name) \(self.releaseDate.onlyDateDescription)"
    }
    
    var proxyForComparison: String {
        return "\(self.releaseDate.onlyDateDescription) \(self.name)"
    }
}

extension Season : CustomStringConvertible{
    var description : String {
        return "name: \(self.name), release Date: \(self.releaseDate.onlyDateDescription), count of episodes: \(self.episodesCount)"
    }
}

extension Season : Equatable{
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season : Hashable{
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season : Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}



