//
//  PokemonNetworkManager0.swift
//  Pokemon
//
//  Created by iMommo on 08/11/22.
//

import Foundation



class PokemonNetworkMananger {
    
    var pokemons = [PokemonDataModel]()
    
    
//    func fetchPokemonsData()  {
//        URLSession.shared.request(url: Constants.pokemonsViewControllerLimit50, expecting: ResourceDataModel.self){
//            [weak self] result in
//            switch result {
//            case .success(let receivedPokemonsData):
//                DispatchQueue.main.async {
//                    self?.pokemons = receivedPokemonsData.results
////                    self?.pokemonsTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    func fetchPokemonsDetails()  {
//        URLSession.shared.request(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id ?? 0)/"), expecting: PokemonDetailsDataModel.self){
//            [weak self] result in
//            switch result {
//            case .success(let receivedPokemonsData):
//                DispatchQueue.main.async {
////                    self?.pok = receivedPokemonsData.stats
//                    print(receivedPokemonsData)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}
