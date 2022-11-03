//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

extension Thread {

    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}


// All the tasks (Methods) will be moved to the main thread
@MainActor class PokemonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var pokemons = [PokemonDataModel]()
    var pokemonImageURL = [PokemonSprites]()
    var selectedPokemonName = ""
    var viewModel : PokemonsViewModel!
    
    init(viewModel : PokemonsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        URLSession.shared.request(url: Constants.basePokemonsURL, expecting: ResourceDataModel.self){
            [weak self] result in
//            print(Thread.current.name)
            print(result)
            switch result {
            case .success(let receivedData):
                DispatchQueue.main.async {
                    self?.pokemons = receivedData.results
                    self?.pokemonsTableView.reloadData()
                }
              
            case .failure(let error):
                print(error)

            }
        }
    }
    
    
    func fetchPokemonImage()  {
        URLSession.shared.request(url: Constants.basePokemonsURL, expecting: PokemonSprites.self){
            [weak self] result in
//            print(Thread.current.name)
            print(result)
            switch result {
            case .success(let receivedData):
                DispatchQueue.main.async {
                    self?.pokemonImageURL = receivedData.sprites
                    self?.pokemonsTableView.reloadData()
                }
              
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
        return pokemons.count
    }
    
//    TableViewCell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        cell.fillPokemonData(pokName: pokemons[indexPath.row].name, pokImg: "2")
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
