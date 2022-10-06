//
//  Region.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 06/10/2022.
//

import Foundation

enum Region: String, CaseIterable{
    case kanto
    case johto
    case hoenn
    case sinnoh
    case unova
    case kalos
    case alola
    case galar
    case hisui
    
    var regionNumber: Int {
        switch self {
        case .kanto:
            return 1
        case .johto:
            return 2
        case .hoenn:
            return 3
        case .sinnoh:
            return 4
        case .unova:
            return 5
        case .kalos:
            return 6
        case .alola:
            return 7
        case .galar:
            return 8
        case .hisui:
            return 9
        }
    }
    
}
