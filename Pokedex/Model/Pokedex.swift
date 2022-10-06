//
//  Pokedex.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 04/10/2022.
//
import Foundation

// MARK: - Pokedex
struct Pokedex: Codable {
    
    let pokemonEntries: [PokemonEntry]
    
    enum CodingKeys: String, CodingKey {
        case pokemonEntries = "pokemon_entries"
    }
}

// MARK: - PokemonEntry
struct PokemonEntry: Codable {
    let entryNumber: Int
    let pokemonSpecies: PokemonSpecies

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}

// MARK: - PokemonSpecies
struct PokemonSpecies: Codable {
    let name: String
    let url: String
}


struct PokemonEntries: Codable {
    
}
