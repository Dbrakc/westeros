//
//  Character.swift
//  Westeros
//
//  Created by David Braga  on 6/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import Foundation

final class Person{
    
    // MARK : - Properties
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
       /* get{
            if let alias = _alias {
                return alias
            }else{
                return ""
            }
        }*/
        return _alias ?? ""
    }
    
    // MARK : - Initialization
    
    init(name: String, alias: String? = nil, house: House){
        self.name = name
        self._alias = alias
        self.house = house
    }
    
    /*convenience init(name: String, house: House){
        self.init(name: name, alias: nil, house: house)
       
    }*/
}

extension Person {
    var proxy: String {
        return "\(name)\(alias)\(house.name)"
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person: Hashable {
    var hashValue: Int {
        //
        return proxy.hashValue
    }
}

extension Person: Equatable{
    static func == (lhs: Person,rhs: Person)->Bool{
        return lhs.proxy == rhs.proxy
    }
}
