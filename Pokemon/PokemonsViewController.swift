//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class PokemonsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPokemonsTableView()
      
    }
    
    
    private let pokemonsTableView : UITableView = {
        let table = UITableView()
        table.register(PokemonCell.self, forCellReuseIdentifier: Constants.pokemonCellIdentifier)
        return table
    }()
    
    private func setupPokemonsTableView() {
        view.addSubview(pokemonsTableView)
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

}
