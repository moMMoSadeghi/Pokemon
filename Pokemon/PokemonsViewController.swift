//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit
import Kingfisher

extension Thread {

//    An extension to check the Thread in the PokemonsViewController
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
@MainActor class PokemonsViewController: UIViewController {
   
    
    var pokemonsName = [PokemonDataModel]()
    var pokemonsImage = PokemonSprites()
    var selectedPokemonName = ""
    var pokemonsURLs = [String]()
    var viewModel : PokemonsViewModel!
    var pokemonNetworkManager = PokemonNetworkManager()
    var delegate : DetailsPokemonViewControllerDelegate?
    
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
        pokemonNetworkManager.fetchPokemonImageURL(number: 1)
        fetchPokemonsName()
        fetchPokemonsImage()
        }

    

   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    func fetchPokemonsName()  {
        URLSession.shared.request(url: Constants.pokemonsViewControllerLimit50, expecting: ResourceDataModel.self){
            [weak self] result in
//            print(result)
            switch result {
            case .success(let receivedPokemonsName):
                DispatchQueue.main.async {
                    self?.pokemonsName = receivedPokemonsName.results
                    self?.pokemonsTableView.reloadData()
                }
                
              
            case .failure(let error):
                print(error)

            }
        }
    }
    
    func fetchPokemonsImage()  {
        URLSession.shared.request(url: Constants.detailsPokemonViewController, expecting: DetailsPokemonDataModel.self){
            [weak self] result in
            print(result)
            switch result {
            case .success(let receivedPokemonsImage):
                DispatchQueue.main.async {
                    print(receivedPokemonsImage)
//                    self?.pokemonsImage = receivedPokemonsImage.sprites.front_default
                    self?.pokemonsTableView.reloadData()

                }
                
              
            case .failure(let error):
                print(error)

            }
        }
    }
    
    
//    func fetchPokemonsImage(url : String, completion: @escaping (DetailsPokemonDataModel) -> Void)  {
//       let url = URL(string: url)
//        let session = URLSession.shared
//        let dataImage = session.dataTask(with: url!) { data, _, _ in
//            do {
//                let fetchingData = try JSONDecoder().decode(DetailsPokemonDataModel.self, from: data!)
//                completion(fetchingData)
//                print("DONE")
//            } catch {
////                print(err!.localizedDescription)
//            }
//        }
//        dataImage.resume()
//
//    }
    
    
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
    
   
    
    

}

// Configuring UI
extension PokemonsViewController {
    
//    Setting Pokemon TableView Constraint
    private func setupPokemonsTableViewConstraint() {
        view.addSubview(pokemonsTableView)
        pokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        pokemonsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokemonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
    }
}



extension PokemonsViewController : UITableViewDelegate, UITableViewDataSource {
    
    //    TableViewCell counter
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsName.count
    }
    
    //    TableViewCell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
//        cell.fillPokemonsNameData(pokName: pokemonsName[indexPath.row].name)
        cell.fillPokemonsData(pokName: pokemonsName[indexPath.row].name, pokID: "\(indexPath.row + 1)")
//        let imageURLString = pokemonsImage[indexPath.row].front_default
//        cell.fillPokemonsImageData(pokImage: pokemonsImage[indexPath.row].front_default)
//        cell.configureCell(urlString: imageURLString)
        return cell
    }
    
    
//     TableViewCell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
//    TableViewCell Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemonName = pokemonsName[indexPath.row].name
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsViewController = DetailsPokemonViewController()
        detailsViewController.pokemonSelected = selectedPokemonName
        self.present(detailsViewController, animated: true)
    }
}


//extension UIImageView {
//    func downloaded (from url : URL, contentMode mode : ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data,
//                let image = UIImage(data: data)
//            else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link : String, contentMode mode : ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
