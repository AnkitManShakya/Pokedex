//
//  AppIcon.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 01/10/2022.
//

import UIKit

extension UIImage {
    
    private static func icon(for value: AppIcon) -> UIImage? {
        if let image = UIImage(named: value.rawValue) {
            return image
        } else {
            print("Image not found for \(value.rawValue)")
            return nil
        }
    }
    
    static let pokedexIcon = icon(for: .pokedexIcon)
    
}

enum AppIcon: String {
    
    case pokedexIcon
    
}
