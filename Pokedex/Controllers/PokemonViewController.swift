//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 08/10/2022.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemonName: String
    var pokemon: PokemonResponse?
    
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Types : "
        label.textColor = .white
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(typeLabel)
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
     init(pokemonName: String){
        self.pokemonName = pokemonName
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupPokemon(pokemonName: pokemonName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(image)
        contentView.addSubview(stackView)
        contentView.addSubview(statsStackView)
        setupBackButtonItem()
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: view.bounds.height/3),
            
            image.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: view.bounds.height/4),
            
            stackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            statsStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            statsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            statsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            statsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),

        
        ])
        
    }
    
    func setupPokemon(pokemonName: String) {
        guard let url = API.pokemon(pokemonName).apiUrl else { return }
        APICaller.shared.apiCall(url: url) { [weak self] (pokemon: PokemonResponse ) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image.kf.setImage(with: URL(string: pokemon.sprites.frontDefault))
                self.topView.backgroundColor = PokemonType(rawValue: pokemon.types[0].type.name)?.color
                self.navigationController?.navigationBar.backgroundColor = PokemonType(rawValue: pokemon.types[0].type.name)?.color
                self.title = pokemonName.capitalizeFirstLetter()
                self.addTypes(typeInputs: pokemon.types)
                self.addStats(statsInput: pokemon.stats)
            }
        }
    }
    
    func setupBackButtonItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                       style: .plain, target: self, action: #selector(backbuttonAction))
           item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = item

    }
    
    @objc func backbuttonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func addStats(statsInput: [Stat]){
        statsInput.forEach { [weak self] stat in
            guard let self = self else { return }
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = stat.stat.name.capitalizeFirstLetter()
            label.textColor = .white
            
            let statValue = Float(stat.baseStat)/100
            let progressBar = UIProgressView()
            progressBar.progressTintColor = Stats(rawValue: stat.stat.name)?.color
            progressBar.setProgress(statValue, animated: true)
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            progressBar.layer.cornerRadius = 5
            progressBar.trackTintColor = .white
            progressBar.clipsToBounds = true
            
            
            view.addSubview(label)
            view.addSubview(progressBar)
            
            NSLayoutConstraint.activate([
                progressBar.heightAnchor.constraint(equalToConstant: 10),
                
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.widthAnchor.constraint(equalToConstant: 200),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                progressBar.leadingAnchor.constraint(equalTo: label.trailingAnchor),
                progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                progressBar.centerYAnchor.constraint(equalTo: label.centerYAnchor),
//                progressBar.topAnchor.constraint(equalTo: view.topAnchor),
//                progressBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            ])
            
            self.statsStackView.addArrangedSubview(view)
        }
        
    }
    
    func addTypes(typeInputs: [TypeElement]){
        typeInputs.forEach { [weak self] type in
            guard let self = self else { return }
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = PokemonType(rawValue: type.type.name)?.color
            view.layer.cornerRadius = 15
            let label = UILabel()
            label.text = type.type.name.capitalizeFirstLetter()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            ])
            self.stackView.addArrangedSubview(view)
        }
    }
    
}
