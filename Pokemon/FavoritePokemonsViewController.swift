//
//  FavoritePokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class FavoritePokemonsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
   
    
   
    
    var favoritePokemons = [FavoritePokemonModel]()
    var fakePokemons = ["A", "B", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Pokemons"
        setupFavoritePokemonsTableView()
        
    }
    
    
    private let favoriteTableView : UITableView = {
        let table = UITableView()
        table.register(FavoriteCell.self, forCellReuseIdentifier: Constants.favoritePokemonCellIdentifier)
        return table
    }()
    
    private func setupFavoritePokemonsTableViewConstraint() {
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
       
    }
    
    private func setupFavoritePokemonsTableView() {
        view.addSubview(favoriteTableView)
        setupFavoritePokemonsTableViewConstraint()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakePokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritePokemonCellIdentifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.fillFavoritePokemonData(pokImg: "2", pokName: "4444")
//        cell.fillPokemonData(pokName: "The NAME", pokImg: "2")
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }

    
    

}
