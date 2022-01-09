//
//  Country.swift
//  Countries
//
//  Created by Excell Nicolas on 1/9/22.
//

import Foundation

struct Country: Decodable {
    let name: CountryName
    let flags: Flags
    let region: String
//    let capital: [String]
    let population: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case flags
        case region
//        case capital
        case population
    }
}

struct CountryName: Decodable {
    let common: String
    let official: String
    
    enum CodingKeys: String, CodingKey {
        case common
        case official
    }
}

struct Flags: Decodable {
    let png: String
    
    enum CodingKeys: String, CodingKey {
        case png
    }
}
