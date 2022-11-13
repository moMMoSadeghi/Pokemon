//
//  FavoritePokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit


class FavoritePokemonsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    
    
    //MARK: - Variables
    
    let userDefaulfManager = UserDefaulsManager()
    var favoritePokemons   = [FavoritePokemonModel]()
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title           = "Favorite Pokemons"
        view.backgroundColor = .systemGray5
        setupFavoritePokemonsTableView()
//        recivingSavedPokemonsFromUserDefaults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recivingSavedPokemonsFromUserDefaults()
    }
    
    
    
    //MARK: -   UI IBOutlets
    
    
    
    ///  Creating Favorite Pokemon TableView
    private lazy var favoritePokemonTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "favoriteViewControllerBackground")
        table.register(FavoriteCell.self, forCellReuseIdentifier: Constants.favoritePokemonCellIdentifier)
        return table
    }()
    
    
    /// Setting up FavoritePokemonTableViewConstraints
    private func setupFavoritePokemonsTableViewConstraint() {
        favoritePokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritePokemonTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        favoritePokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        favoritePokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        favoritePokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
    }
    
    
    ///  Setting up FavoritePokemonsTableView
    private func setupFavoritePokemonsTableView() {
        view.addSubview(favoritePokemonTableView)
        setupFavoritePokemonsTableViewConstraint()
        favoritePokemonTableView.delegate = self
        favoritePokemonTableView.dataSource = self
    }
    
    
    
    /// Updating Saved Pokemons from UserDefaults
    func recivingSavedPokemonsFromUserDefaults() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.favoritePokemons = self.userDefaulfManager.retreivedPokemons()
            print(self.favoritePokemons)
            self.favoritePokemonTableView.reloadData()
        }
    }
    
    
    
    
    
    
    /// Deleting Saved Pokemons from UserDefaults
    func deleteSwipedPokemon(id : Int, name: String) {
        let selectedPokemon = FavoritePokemonModel(id: id, name: name)
        userDefaulfManager.deletePokemons(pokemon: selectedPokemon)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            print(self.favoritePokemons)
            self.favoritePokemonTableView.reloadData()
        }
    }
    
    
}





//MARK: - TableView Extensions

extension FavoritePokemonsViewController {
    
    
    
    /// numberOfRowsInSection delegate method
    /// - Parameters:
    ///   - tableView: FavoritePokemon TableView
    ///   - section: Section description
    /// - Returns: Number of Pokemon rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePokemons.count
    }
    
    
    /// cellForItemAt contents
    /// - Parameters:
    ///   - tableView: FavoritePokemon TableView
    ///   - indexPath: Selected row
    /// - Returns: Contents for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritePokemonCellIdentifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.fillFavoritePokemonData(pokID: "\(favoritePokemons[indexPath.row].id)", pokName: favoritePokemons[indexPath.row].name)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    
    /// TableViewCell Height
    /// - Parameters:
    ///   - tableView: FavoritePokemon TableView
    ///   - indexPath: Each row
    /// - Returns: Height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
    /// Configuring Swipe left Gesture
    /// - Parameters:
    ///   - tableView: FavoritePokemon TableView
    ///   - indexPath: Each row
    /// - Returns: Swipping Elements  for each row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] (_, _, completionHandler) in
            self.deleteSwipedPokemon(id: self.favoritePokemons[indexPath.row].id, name: self.favoritePokemons[indexPath.row].name)
            print("deleted: \(indexPath.row + 1)")
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}


