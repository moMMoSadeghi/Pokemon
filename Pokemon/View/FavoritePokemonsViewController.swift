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
    var fakePokemons = ["A"]
    
    
    private let favoritePokemonImage : UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.layer.cornerRadius = (image.frame.size.width ) / 2
        image.layer.borderWidth = 3.0
        image.backgroundColor = .white
        image.layer.borderColor = UIColor.green.cgColor
        return image
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Pokemons"
        setupFavoritePokemonsTableView()
        

    }
    
    func didSendFavoritePokemon(favoritePokemon: FavoritePokemonModel) {
        favoritePokemonImage.image = UIImage(named: favoritePokemon.image)
//        pokNameLable.text = favoritePokemon.name
    }
    
    
    
    private let favoritePokemonTableView : UITableView = {
        let table = UITableView()
        table.register(FavoriteCell.self, forCellReuseIdentifier: Constants.favoritePokemonCellIdentifier)
        return table
    }()
    
    private func setupFavoritePokemonsTableViewConstraint() {
        favoritePokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritePokemonTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoritePokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        favoritePokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        favoritePokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
       
    }
    
    private func setupFavoritePokemonsTableView() {
        view.addSubview(favoritePokemonTableView)
        setupFavoritePokemonsTableViewConstraint()
        favoritePokemonTableView.delegate = self
        favoritePokemonTableView.dataSource = self
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
