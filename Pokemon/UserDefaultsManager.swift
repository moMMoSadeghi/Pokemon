//
//  UserDefaultsManager.swift
//  Pokemon
//
//  Created by iMommo on 10/11/22.
//

import Foundation



class UserDefaulsManager : Codable {
    
    
    var favoritePokemons : [FavoritePokemonModel]?
    
    
    func savedPokemons(pokemon : FavoritePokemonModel) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pokemon)
            print(data)
            UserDefaults.standard.set(data, forKey: "favoritePokemonObject")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    
     func retreivedPokemons() -> [FavoritePokemonModel] {
        
        if let data = UserDefaults.standard.data(forKey: "favoritePokemonObject") {
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([FavoritePokemonModel].self, from: data)
                self.favoritePokemons = pokemons
                print(pokemons)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
         return favoritePokemons ?? []
    }
   
    
    
}


//how to save an array objects into userDefaults 
