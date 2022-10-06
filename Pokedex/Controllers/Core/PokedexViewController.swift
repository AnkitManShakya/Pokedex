//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 01/10/2022.
//

import UIKit

class PokedexViewController: UIViewController {
    
    var pokemonEntries: [PokemonEntry] = []
    var searchPokemonEntries: [PokemonEntry] = []
    var searchBarIsEmpty: Bool = true

    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: PokedexViewController())
        controller.searchBar.placeholder = "Pokemon"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    lazy var emptyResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No matching results"
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        fetchData()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func fetchData() {
        APICaller.shared.apiCall(url: API.pokedex.apiUrl) {[weak self] (result: Pokedex) in
            guard let self = self else { return }
            self.pokemonEntries = result.pokemonEntries
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchResultsUpdater = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        setupNavigationBar()
        view.addSubview(collectionView)
        view.addSubview(emptyResultsLabel)
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])
    }
    
    private func setupNavigationBar() {
        
        title = "Pokedex"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
        
        let textAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.white]
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = textAttributes
        appearance.largeTitleTextAttributes = textAttributes
        appearance.backgroundColor = .clear
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.searchController = searchController
    }
    
}

extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if searchPokemonEntries.isEmpty && searchBarIsEmpty{
                return pokemonEntries.count
            } else {
                return searchPokemonEntries.count
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        if searchPokemonEntries.isEmpty {
            cell.configureCellByPokemonEntry(pokemonEntry: pokemonEntries[indexPath.item])
        } else {
            cell.configureCellByPokemonEntry(pokemonEntry: searchPokemonEntries[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (self.view.frame.width - 20 )/2, height: (self.view.frame.height)/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension PokedexViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        guard let query = searchBar.text?.lowercased(),
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count > 0,
              let resultsController = searchController.searchResultsController as? PokedexViewController else { return }
        
        resultsController.searchPokemonEntries = resultsController.pokemonEntries.compactMap{ $0.pokemonSpecies.name.contains(query) ? $0 : nil  }
        resultsController.searchBarIsEmpty = query.isEmpty
        
        if !query.isEmpty && resultsController.searchPokemonEntries.isEmpty {
            resultsController.emptyResultsLabel.isHidden = false
        } else {
            resultsController.emptyResultsLabel.isHidden = true
        }
        
        resultsController.collectionView.reloadData()

    }
    
    
}
