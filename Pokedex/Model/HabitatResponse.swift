//
//  HabitatResponse.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 06/10/2022.
//

import Foundation

// MARK: - HabitatResponse
struct HabitatResponse: Codable {
    let id: Int
    let name: String
    let names: [PokemonName]
    let pokemonSpecies: [PokemonSpecy]

    enum CodingKeys: String, CodingKey {
        case id, name, names
        case pokemonSpecies = "pokemon_species"
    }
}

// MARK: - Name
struct PokemonName: Codable {
    let language: PokemonSpecy
    let name: String
}

// MARK: - PokemonSpecy
struct PokemonSpecy: Codable {
    let name: String
    let url: String
}

