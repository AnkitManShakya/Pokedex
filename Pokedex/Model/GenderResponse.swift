//
//  GenderResponse.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 06/10/2022.
//
import Foundation

// MARK: - GenderResponse
struct GenderResponse: Codable {
    let id: Int
    let name: String
    let pokemonSpeciesDetails: [PokemonSpeciesDetail]
    let requiredForEvolution: [RequiredForEvolution]

    enum CodingKeys: String, CodingKey {
        case id, name
        case pokemonSpeciesDetails
        case requiredForEvolution
    }
}

// MARK: - PokemonSpeciesDetail
struct PokemonSpeciesDetail: Codable {
    let pokemonSpecies: RequiredForEvolution
    let rate: Int

    enum CodingKeys: String, CodingKey {
        case pokemonSpecies
        case rate
    }
}

// MARK: - RequiredForEvolution
struct RequiredForEvolution: Codable {
    let name: String
    let url: String
}
