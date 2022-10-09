//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 01/10/2022.
//

import UIKit
import TTGTags

class GenderViewController: UIViewController {
    
    var pokemonEntries: [PokemonSpeciesDetail] = []
    var selectedGender: Gender = .female
    
    lazy var tagCollectionView: TTGTextTagCollectionView = {
        let collectionView = TTGTextTagCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        
        let unselectedStyle = TTGTextTagStyle()
        unselectedStyle.borderColor = .gray
        unselectedStyle.backgroundColor = .clear
        unselectedStyle.extraSpace = CGSize(width: 20, height: 20)
        unselectedStyle.textAlignment = .center
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.borderColor = .gray
        selectedStyle.backgroundColor = .gray
        selectedStyle.extraSpace = CGSize(width: 20, height: 20)
        selectedStyle.textAlignment = .center
        
        let tags = Gender.allCases.map({ TTGTextTag(content: TTGTextTagStringContent(
            text: $0.rawValue.capitalizeFirstLetter(),
            textFont: UIFont.systemFont(ofSize: 18),
            textColor: .white),
                                                    style: unselectedStyle) })
        
        tags.map({$0.selectedStyle = selectedStyle})
        collectionView.add(tags)
        
        collectionView.reload()
        return collectionView
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
        APICaller.shared.apiCall(url: API.gender(selectedGender).apiUrl) {[weak self] (result: GenderResponse) in
            guard let self = self else { return }
            self.pokemonEntries = result.pokemonSpeciesDetails
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        tagCollectionView.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        setupNavigationBar()
        view.addSubview(tagCollectionView)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            tagCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tagCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: tagCollectionView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    private func setupNavigationBar() {
        
        title = "Pokedex - Gender"
        
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
        
    }
    
}

extension GenderViewController: TTGTextTagCollectionViewDelegate {
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        let description = tag.content.getAttributedString().string
        selectedGender = Gender(rawValue: description.lowercased())  ?? .female
        fetchData()
        collectionView.reloadData()
    }
    
}

extension GenderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonEntries.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCellByPokemonSpeciesDetail(pokemonSpeciesDetail: pokemonEntries[indexPath.item])
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

