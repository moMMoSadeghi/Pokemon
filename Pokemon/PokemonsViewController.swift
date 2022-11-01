//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class PokemonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var pokemons = [PokemonDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemons"
        setupPokemonsTableView()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        
    }
    
    
    private let pokemonsTableView : UITableView = {
        let table = UITableView()
        table.register(PokemonCell.self, forCellReuseIdentifier: Constants.pokemonCellIdentifier)
        return table
    }()
    
    private func setupPokemonsTableView() {
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
        view.addSubview(pokemonsTableView)
        pokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
       
    }
    
//    TableViewCell counter
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
//    TableViewCell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        cell.fillPokemonData(pokName: pokemons[indexPath.row].name, pokImg: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}
