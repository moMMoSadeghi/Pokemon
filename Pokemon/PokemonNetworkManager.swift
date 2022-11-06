//
//  PokemonNetworkManager.swift
//  Pokemon
//
//  Created by iMommo on 03/11/22.
//

import Foundation


struct PokemonNetworkManager {
//    let pokemonsURL = "https://pokeapi.co/api/v2/pokemon-form/"
    
    func fetchPokemonImageURL(number : Int) {
        let pokemonURL = "https://pokeapi.co/api/v2/pokemon-form/\(number)/"
        performRequest(urlString: pokemonURL)
    }
    
    func performRequest(urlString : String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                return
            } else if let receivedData = data {
                let dataString = String(data: receivedData, encoding: .utf8)
                print(dataString ?? "Unkonwn")
            }
                  
        }
        task.resume()
        
    }
    
    
}
