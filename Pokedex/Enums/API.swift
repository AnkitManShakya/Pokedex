//
//  API.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 04/10/2022.
//

import Foundation

enum API {
    
    case pokedex
    case pokemon(Int)
    case region(Region)
    case habitat(Habitat)
    case gender(Gender)
    
    var extensionPath: String {
        switch self {
        case .pokedex:
            return "/pokedex/1/"
        case .pokemon(let index):
            return "/pokemon/\(index)/"
        case .region(let region):
            return "/region/\(region.regionNumber)/"
        case .gender(let gender):
            return "/gender/\(gender.genderNumber)/"
        case .habitat(let habitat):
            return "/pokemon-habitat/\(habitat.habitatNumber)/"
        }
    }
    
    var apiUrl: URL? {  URL(string: Constants.baseURL + self.extensionPath)}
    
}



