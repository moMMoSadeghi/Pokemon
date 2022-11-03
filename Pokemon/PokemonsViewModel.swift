//
//  PokemonsViewModel.swift
//  Pokemon
//
//  Created by iMommo on 02/11/22.
//

import Foundation



class PokemonsViewModel {
    init(networkManaget : NetworkManager){
        self.networkManager = networkManaget
    }
    let networkManager : NetworkManager
    
    
//    func fetchPokemons()  {
//        networkManager.fetchDataFromServer(urlName: Constants.stringURL, type: .get) { [weak self] pokemon, error in {
//
//        }
//            
//        }
//        URLSession.shared.request(url: Constants.pokemonsURL, expecting: ResourceDataModel.self){
//            [weak self] result in
//            print(result)
//            switch result {
//            case .success(let receivedData):
//                self?.pokemons = receivedData.results
//            case .failure(let error):
//                print(error)
//
//            }
//        }
//    }
}
