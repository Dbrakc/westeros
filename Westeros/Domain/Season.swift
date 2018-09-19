//
//  Season.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import Foundation
typealias Episode = String

final class Season{
    
    let name: String
    let episodes: [Episode]
    var episodesCount: Int {
        return self.episodes.count
    }
    let date : Date
    
    init?(withName name: String, date: Date, episodesList episodes: [Episode]){
        self.name = name
        guard  episodes.count > 0 else{return nil}
        self.date = date
        self.episodes = episodes
    }
    
    
    
    
}
