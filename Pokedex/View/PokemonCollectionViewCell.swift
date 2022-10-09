//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 02/10/2022.
//

import UIKit
import Kingfisher

class PokemonCollectionViewCell: UICollectionViewCell {
    
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var pokedexNo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
    let nameAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor.white,
        .font: UIFont.systemFont(ofSize: 20 , weight: .semibold)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 15
        
        contentView.addSubview(name)
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokedexNo)

        NSLayoutConstraint.activate([
        
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            pokedexNo.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            pokedexNo.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),

            pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            pokemonImage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            pokemonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),


        ])
    }
    
    func configureCellByPokemonEntry(pokemonEntry: PokemonEntry) {
        name.attributedText = NSAttributedString(string: pokemonEntry.pokemonSpecies.name.capitalizeFirstLetter(), attributes: nameAttributes)
        pokedexNo.text = "# \(pokemonEntry.entryNumber)"
        fetchPokemon(indicator: "\(pokemonEntry.entryNumber)")
    }
    
    func configureCellByPokemonSpeciesDetail(pokemonSpeciesDetail: PokemonSpeciesDetail) {
        name.attributedText = NSAttributedString(string: pokemonSpeciesDetail.pokemonSpecies.name.capitalizeFirstLetter(), attributes: nameAttributes)
        pokedexNo.isHidden = true
        fetchPokemon(indicator: pokemonSpeciesDetail.pokemonSpecies.name)
    }
    
    func configureCellByName(pokemonSpecy: PokemonSpecy) {
        name.attributedText = NSAttributedString(string: pokemonSpecy.name.capitalizeFirstLetter(), attributes: nameAttributes)
        pokedexNo.isHidden = true
        fetchPokemon(indicator: pokemonSpecy.name)
    }
    
    func fetchPokemon(indicator: String) {
        guard let url = API.pokemon(indicator).apiUrl else { return }
        APICaller.shared.apiCall(url: url) { [weak self] (pokemon: PokemonResponse ) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pokemonImage.kf.setImage(with: URL(string: pokemon.sprites.frontDefault))
                self.backgroundColor = PokemonType(rawValue: pokemon.types[0].type.name)?.color
            }
        }
    }
    

    
}
