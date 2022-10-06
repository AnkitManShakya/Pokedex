//
//  AppColor.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 04/10/2022.
//

import UIKit

extension UIColor {
    static func color(for value: AppColor) -> UIColor {
        if let color = UIColor(named: value.rawValue) {
            return color
        } else {
            assertionFailure("failed to find the color for \(value.rawValue)")
            return .systemGray
        }
    }

    static let normal = color(for: .normal)
    static let fighting = color(for: .fighting)
    static let flying = color(for: .flying)
    static let poison = color(for: .poison)
    static let ground = color(for: .ground)
    static let rock = color(for: .rock)
    static let bug = color(for: .bug)
    static let ghost = color(for: .ghost)
    static let steel = color(for: .steel)
    static let fire = color(for: .fire)
    static let water = color(for: .water)
    static let grass = color(for: .grass)
    static let electric = color(for: .electric)
    static let psychic = color(for: .psychic)
    static let ice = color(for: .ice)
    static let dragon = color(for: .dragon)
    static let dark = color(for: .dark)
    static let fairy = color(for: .fairy)
    static let unknown = color(for: .unknown)
    static let shadow = color(for: .shadow)

}

enum AppColor: String {

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
    
}
