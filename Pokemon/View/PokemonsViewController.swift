//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit
import Kingfisher





class PokemonsViewController: UIViewController,
                              UISearchBarDelegate,
                              UISearchResultsUpdating {
    
    
    
    
    
    
    let searchedBarPokemons    = UISearchController()
    var pokemons               = [PokemonDataModel]()
    var searchedPokemons       : [PokemonDataModel]!
    var pokemonsViewModel      = PokemonsViewModel()
    //    var pokemonsViewModel   = PokemonsViewModel(pokemonsData: <#PokemonDataModel#>)
    
    
    
    
    
    init() {
        //        init(viewModel : PokemonsViewModel) {
        //            self.viewModel = viewModel
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if #available(iOS 13.0, *) {
            searchedBarPokemons.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Pokemons", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else {
            print("Device is not compatible!")
        }
        
    }
    
    //MARK: - Application LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemons"
        view.backgroundColor = .systemGray5
        view.addSubview(activityIndicator)
        //        pokemons             = pokemonsViewModel.pokemonsData
        configureTableView()
        fetchPokemonsData()
        setupPokemonsTableViewConstraint()
        ConfigSearchBarController()
        //        pokemonsViewModel.fetchPokemonsData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    
    
    
    
    
    //MARK: -   UI Outlets
    
    
    /// TableView
    private lazy var pokemonsTableView : UITableView = {
        let table             = UITableView()
        table.register(PokemonCell.self, forCellReuseIdentifier: Constants.pokemonCellIdentifier)
        return table
    }()
    
    ///  Configuration for TableView
    func configureTableView() {
        pokemonsTableView.delegate        = self
        pokemonsTableView.backgroundColor = UIColor(named: "pokemonsViewControllerBackground")
        pokemonsTableView.dataSource      = self
    }
    
    
    /// Creating ActivityIndicator
    private let activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        //        activity.hidesWhenStopped = true
        activity.color = UIColor(named: "green")
        return activity
    }()
    
    
    //MARK: -   Methods
    
    
    /// Fetching Pokemons Data
    func fetchPokemonsData()  {
        URLSession.shared.request(url: Constants.pokemonsViewControllerLimit999, expecting: ResourceDataModel.self){
            [weak self] result in
            switch result {
            case .success(let receivedPokemonsData):
                DispatchQueue.main.async {
                    self?.pokemons = receivedPokemonsData.results
                    self?.activityIndicator.startAnimating()
                    self?.pokemonsTableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    //MARK: - Search Bar
    
    
    /// UISearchResultsUpdating delegation method
    /// - Parameter searchController: searchBarPokemons
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchedBarPokemons.searchBar.text else { return }
        filteredForSearchedPokemons(searchText: searchBarText)
    }
    
    
    /// Filtering searchedPokemons
    /// - Parameter searchText: searchText description
    private func filteredForSearchedPokemons(searchText : String) {
        searchedPokemons = pokemons.filter {
            pok in
            if searchedBarPokemons.searchBar.text != "" {
                let matchedPokemons = pok.name.lowercased().contains(searchText.lowercased())
                return matchedPokemons
            } else {
                return true
            }
        }
        pokemonsTableView.reloadData()
    }
    
    /// SearchBar Delegate Method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPokemons = []
        if searchText == "" {
            searchedPokemons = pokemons
            pokemonsTableView.isHidden = false
        } else {
            for poke in pokemons {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    searchedPokemons.append(poke)
                }
            }
        }
        self.pokemonsTableView.reloadData()
    }
    
    
    
    /// Configuration for SearchBar
    func ConfigSearchBarController() {
        searchedBarPokemons.loadViewIfNeeded()
        navigationItem.searchController                = searchedBarPokemons
        navigationItem.hidesSearchBarWhenScrolling     = true
        searchedBarPokemons.searchResultsUpdater       = self
        searchedBarPokemons.searchBar.delegate         = self
        searchedBarPokemons.definesPresentationContext = true
        searchedBarPokemons.obscuresBackgroundDuringPresentation = false
    }
    
    
    
    /// setupPokemonsTableViewConstraint
    private func setupPokemonsTableViewConstraint() {
        view.addSubview(pokemonsTableView)
        pokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        pokemonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
    }
    
    
    
}


//MARK: - TableView Extensions

extension PokemonsViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    
    /// numberOfRowsInSection delegate method
    /// - Parameters:
    ///   - tableView: Pokemon TableView
    ///   - section: section description
    /// - Returns: Number of Pokemon rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedBarPokemons.isActive {
            return searchedPokemons.count
        } else {
            return pokemons.count
        }
    }
    
    
    /// cellForItemAt contents
    /// - Parameters:
    ///   - tableView: Pokemon TableView
    ///   - indexPath: Selected row
    /// - Returns: Contents for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        //        let thisPokemon : PokemonDataModel!
        //        if searchedBarPokemons.isActive {
        //            cell.fillPokemonsData(pokName: searchedBarPokemons[indexPath.row].name, pokID: "\(indexPath.row + 1)")
        //            thisPokemon = searchedPokemons[indexPath.row]
        //        } else {
        cell.fillPokemonsData(pokName: pokemons[indexPath.row].name, pokID: "\(indexPath.row + 1)")
        
        return cell
    }
    
    
    //
    
    /// TableViewCell Height
    /// - Parameters:
    ///   - tableView: Pokemon TableView
    ///   - indexPath: Each row
    /// - Returns: Height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    
    /// didSelectItemAt to show after Selected
    /// - Parameters:
    ///   - tableView: Pokemon TableView
    ///   - indexPath: Each row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsViewController = DetailsPokemonViewController(pokemon: PokemonDataModel(name: pokemons[indexPath.row].name, url: pokemons[indexPath.row].url), id: indexPath.row)
        self.present(detailsViewController, animated: true)
    }
    
}

