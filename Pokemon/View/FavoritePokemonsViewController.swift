//
//  FavoritePokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit


class FavoritePokemonsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    
    var fakePokemons     = ["A"]
    let userDefaulfManager = UserDefaulsManager()
    var favoritePokemons : [FavoritePokemonModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Pokemons"
        setupFavoritePokemonsTableView()
        recivingSavedPokemonsFromUserDefaults()
    }
    
    func recivingSavedPokemonsFromUserDefaults() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.favoritePokemons = self.userDefaulfManager.retreivedPokemons()
            self.favoritePokemonTableView.reloadData()
        }
    }
    
    //    Creating Favorite Pokemon TableView
    private lazy var favoritePokemonTableView : UITableView = {
        let table = UITableView()
        table.register(FavoriteCell.self, forCellReuseIdentifier: Constants.favoritePokemonCellIdentifier)
        return table
    }()
    
    
    private func setupFavoritePokemonsTableView() {
        view.addSubview(favoritePokemonTableView)
        setupFavoritePokemonsTableViewConstraint()
        favoritePokemonTableView.delegate = self
        favoritePokemonTableView.dataSource = self
    }
    
    
    private func setupFavoritePokemonsTableViewConstraint() {
        favoritePokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritePokemonTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoritePokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        favoritePokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        favoritePokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
    }
    
    
    
    
    
}



extension FavoritePokemonsViewController {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakePokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritePokemonCellIdentifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
//        guard let favPokName = favoritePokemons[indexPath.row].name else { return }
//        guard let favPokID = "\(indexPath.row)" else { return }
        cell.fillFavoritePokemonData(pokID: favoritePokemons[indexPath.row].name , pokName: "\(indexPath.row)")
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}


