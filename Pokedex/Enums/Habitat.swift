//
//  Habitat.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 06/10/2022.
//

import Foundation

enum Habitat: String, CaseIterable {
    
    case cave
    case forest
    case grassland
    case mountain
    case rare
    case roughTerrain = "Rough-Terrain"
    case sea
    case urban
    case watersEdge = "Waters-Edge"
    
    var habitatNumber: Int {
        switch self {
        case .cave:
            return 1
        case .forest:
            return 2
        case .grassland:
            return 3
        case .mountain:
            return 4
        case .rare:
            return 5
        case .roughTerrain:
            return 6
        case .sea:
            return 7
        case .urban:
            return 8
        case .watersEdge:
            return 9
        }
    }
}
