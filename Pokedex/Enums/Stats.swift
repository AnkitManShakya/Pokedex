//
//  Stats.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 09/10/2022.
//

import Foundation
import UIKit

enum Stats: String {
    case hp
    case attack
    case defense
    case specialAttact = "special-attack"
    case specialDefence = "special-defense"
    case speed
    
    var color: UIColor {
        switch self{
        case .hp:
            return UIColor.bug
        case .attack:
            return UIColor.fighting
        case .defense:
            return UIColor.grass
        case .specialAttact:
            return UIColor.psychic
        case .specialDefence :
            return UIColor.water
        case .speed:
            return UIColor.electric

        }
    }
    
}
