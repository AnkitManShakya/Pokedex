//
//  Type.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 04/10/2022.
//

import UIKit

enum PokemonType: String {
    
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
    
    var color: UIColor {
        UIColor.color(for: AppColor(rawValue: self.rawValue) ?? .normal)
    }
    
}
