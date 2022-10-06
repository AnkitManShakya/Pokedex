//
//  Gender.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 06/10/2022.
//

import Foundation

enum Gender: String, CaseIterable {
    
    case female
    case male
    case genderless
    
    var genderNumber: Int {
        switch self {
        case .female:
            return 1
        case .male:
            return 2
        case .genderless:
            return 3
        }
    }

}
