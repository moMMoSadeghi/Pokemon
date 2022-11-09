//
//  FavoritePokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit


class FavoritePokemonsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    
    
    
    
    //    var detailsPokemonViewController = DetailsPokemonViewController()
    var favoritePokemons = [FavoritePokemonModel]()
    var fakePokemons     = ["A"]
//    var pokemon          : PokemonDataModel?
//    var id               : Int?
    
    
//    init(pokemon : PokemonDataModel, id : Int) {
//        self.pokemon = pokemon
//        self.id      = id
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Pokemons"
        setupFavoritePokemonsTableView()
        
        
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
    
    
    
    //    func didSendFavoritePokemon(favoritePokemon: FavoritePokemonModel) {
    //        favoritePokemonImage.image = UIImage(named: favoritePokemon.image)
    //        pokNameLable.text = favoritePokemon.name
    //    }
    
    
    
    
    
}

extension FavoritePokemonsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakePokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritePokemonCellIdentifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.fillFavoritePokemonData(pokImg: "", pokName: "4444")
        //        cell.fillPokemonData(pokName: "The NAME", pokImg: "2")
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}


