//
//  PokemonsViewModel.swift
//  Pokemon
//
//  Created by iMommo on 08/11/22.
//

import Foundation



class PokemonsViewModel {
    
//    let networkManager      : NetworkManager
    var pokemonsData          : [PokemonDataModel]?
    let pokemonNetworkManager = PokemonNetworkMananger()
    
//    init() {
//        self.pokemonsData = 
//    }
//    init(pokemonsData : PokemonDataModel){
//        self.pokemonsData = [pokemonsData]
//    }
//   
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
   
    func fetchPokemonsData()  {
        URLSession.shared.request(url: Constants.pokemonsViewControllerLimit999, expecting: ResourceDataModel.self){
            [weak self] result in
            switch result {
            case .success(let receivedPokemonsData):
//                guard let data = receivedPokemonsData else { return }
                self?.pokemonsData = receivedPokemonsData.results
//                DispatchQueue.main.async {
//                    self?.pokemonsData = receivedPokemonsData.results
//                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
    }
    
    
    
    
    

