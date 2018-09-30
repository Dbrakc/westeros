//
//  Episode.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import Foundation

final class Episode{
    let title: String
    let issueDate: Date
    let resume : String
    weak var season: Season?
    
    init(withTitle title: String, issueDate: Date, resume: String){
        self.title = title
        self.issueDate = issueDate
        self.resume = resume
        
    }
    
}

extension Episode: CustomStringConvertible{

    var description: String {
        let description = "title: \(self.title), issueDate: \(self.issueDate.onlyDateDescription)"
        guard season != nil else {
            return description
        }
        return description + ", season: \(season!.name)"
    }
}

extension Episode{
    var proxyForEquality : String {
        return "\(title) \(self.issueDate.onlyDateDescription)".uppercased()
    }
    var proxyForComparison: String {
        return "\(self.issueDate.onlyDateDescription) \(self.title)".uppercased()
    }
}

extension Episode : Equatable{
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode : Hashable{
    var hashValue : Int {
        return proxyForEquality.hashValue
    }
}

extension Episode : Comparable{
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}
