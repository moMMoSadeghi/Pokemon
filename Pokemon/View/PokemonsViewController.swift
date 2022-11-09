//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit
import Kingfisher





class PokemonsViewController: UIViewController, UISearchBarDelegate {
    
    let searchController    = UISearchController(searchResultsController: nil)
    var pokemons            = [PokemonDataModel]()
    var pokemonsViewModel   = PokemonsViewModel()
    var delegate            : DetailsPokemonViewControllerDelegate?
    //    var pokemonsViewModel   = PokemonsViewModel(pokemonsData: <#PokemonDataModel#>)
    
    
    init() {
        //        init(viewModel : PokemonsViewModel) {
        //            self.viewModel = viewModel
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter Search Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //MARK: - Application LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemons"
        navigationItem.titleView                     = pokemonSearchBar
        view.backgroundColor = UIColor(named: "pokemonsViewControllerBackground")
        pokemonSearchBar.delegate                    = self
        navigationItem.hidesSearchBarWhenScrolling   = false
//        pokemons                                     = pokemonsViewModel.pokemonsData
        configureCollectionView()
        setupPokemonsTableViewConstraint()
        fetchPokemonsData()
        //        pokemonsViewModel.fetchPokemonsData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    //MARK: - Configuration for TableView
    func configureCollectionView() {
        pokemonsTableView.delegate   = self
        pokemonsTableView.dataSource = self
        pokemonsTableView.backgroundColor = UIColor(named: "background")
    }
    
    
    
    
    //MARK: -   UI Outlets
    
    
    //            SearchBar
    private lazy var pokemonSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Pokemons"
        searchBar.sizeToFit()
        return searchBar
    }()
    
    
    //           TableView
    private lazy var pokemonsTableView : UITableView = {
        let table = UITableView()
        table.register(PokemonCell.self, forCellReuseIdentifier: Constants.pokemonCellIdentifier)
        return table
    }()
    
    
    
    
    
    //MARK: -   Methods

    
    //    Fetching Pokemons Data
    
    func fetchPokemonsData()  {
        URLSession.shared.request(url: Constants.pokemonsViewControllerLimit50, expecting: ResourceDataModel.self){
            [weak self] result in
            switch result {
            case .success(let receivedPokemonsData):
                DispatchQueue.main.async {
                    self?.pokemons = receivedPokemonsData.results
                    self?.pokemonsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    //MARK: - Search Bar
    
    
    func searchBarClicked(_ searchBar : UISearchBar) {
        searchBar.resignFirstResponder()
        if let pokemonText = searchBar.text {
            pokemons = []
            pokemonsTableView.reloadData()
            //            pokemonsViewModel.fetchPokemonsData()
            
        }
    }
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        filteredList = []
    //        if searchText == "" {
    //            filteredList = mainViewModel.pokemonList
    //            backgroundOfImageView.removeFromSuperview()
    //            collectionView.isHidden = false
    //        } else {
    //            for poke in mainViewModel.pokemonList {
    //                if poke.name.lowercased().contains(searchText.lowercased()) {
    //                    self.showImageView(isSearchNil: false)
    //                    filteredList.append(poke)
    //                } else if searchText.count > 2{
    //                    self.showImageView(isSearchNil: true)
    //                }
    //            }
    //        }
    //        self.collectionView.reloadData()
    //    }
    
    
}

//MARK: - Setting Pokemon TableView Constraint


extension PokemonsViewController {
    
    private func setupPokemonsTableViewConstraint() {
        view.addSubview(pokemonsTableView)
        pokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
    }
}


//MARK: - TableView Extensions

extension PokemonsViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    //MARK: cellForItemAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        cell.fillPokemonsData(pokName: pokemons[indexPath.row].name, pokID: "\(indexPath.row + 1)")
        return cell
    }
    
    
    //     TableViewCell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    //MARK:  didSelectItemAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsViewController = DetailsPokemonViewController(pokemon: PokemonDataModel(name: pokemons[indexPath.row].name, url: pokemons[indexPath.row].url), id: indexPath.row)
        self.present(detailsViewController, animated: true)
    }
}

