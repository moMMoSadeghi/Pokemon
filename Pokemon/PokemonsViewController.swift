//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

// All the tasks (Methods) will be moved to the main thread
@MainActor class PokemonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var pokemons = [PokemonDataModel]()
    var selectedPokemonName = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
        self.title = "Pokemons"
        navigationItem.titleView = pokemonSearchBar
        setupPokemonsTableViewConstraint()
        fetchPokemons()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    func fetchPokemons()  {
        URLSession.shared.request(url: Constants.pokemonsURL, expecting: ResourceDataModel.self){
            [weak self] result in
            print(result)
            switch result {
            case .success(let receivedData):
                self?.pokemons = receivedData.results
            case .failure(let error):
                print(error)

            }
        }
    }
    
    private let pokemonSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Pokemons"
        searchBar.sizeToFit()
        return searchBar
    }()
    
    
    private let pokemonsTableView : UITableView = {
        let table = UITableView()
        table.register(PokemonCell.self, forCellReuseIdentifier: Constants.pokemonCellIdentifier)
        return table
    }()
    
    private func setupPokemonsTableViewConstraint() {
        view.addSubview(pokemonsTableView)
        pokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
       
    }
    
//    TableViewCell counter
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
//    TableViewCell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        cell.fillPokemonData(pokName: "The NAME", pokImg: "2")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemonName = pokemons[indexPath.row].name
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsViewController = DetailsPokemonViewController()
        detailsViewController.pokemonSelected = selectedPokemonName
        self.present(detailsViewController, animated: true)
    }

}
