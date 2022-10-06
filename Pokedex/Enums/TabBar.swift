//
//  TabBar.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 01/10/2022.
//

import UIKit

enum TabBar {
    case pokedex
    case gender
    case habitat
    
    var icon: String {
        switch self {
        case .pokedex:
            return "circle.circle.fill"
        case .gender:
            return "person.2.circle.fill"
        case .habitat:
            return "aqi.medium"
        }
    }
    
    var title: String {
        switch self {
        case .gender:
            return "Gender"
        case .habitat:
            return "Habitat"
        case .pokedex:
            return "Pokedex"
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .pokedex:
            return PokedexViewController()
        case .gender:
            return GenderViewController()
        case .habitat:
            return HabitatViewController()
        }
    }
}

