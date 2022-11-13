//
//  UserDefaultsManager.swift
//  Pokemon
//
//  Created by iMommo on 10/11/22.
//

import Foundation



class UserDefaulsManager : Codable {
    
    
    /// Save Pokemons to UserDefaults
    func savedPokemons(pokemon : FavoritePokemonModel) {
        var retrivedPokemons = retreivedPokemons()
        if retrivedPokemons.contains(where: {
            $0.name == pokemon.name
        } ) {
            print("duplication of Pokemons")
        } else {
            retrivedPokemons.insert(pokemon, at: 0)
            
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(retrivedPokemons)
                print(data)
                UserDefaults.standard.set(data, forKey: "favoritePokemonsObject")
            } catch {
                print("Unable to Encode Pokemons (\(error))")
            }
        }
    }
    
    
    
    /// Retrieve Saved Pokemons from UserDefaults
    func retreivedPokemons() -> [FavoritePokemonModel] {
        
        var favoritePokemons : [FavoritePokemonModel]?
        if let data = UserDefaults.standard.data(forKey: "favoritePokemonsObject") {
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([FavoritePokemonModel].self, from: data)
                favoritePokemons = pokemons
            } catch {
                print("Unable to Decode Pokemons (\(error))")
            }
        }
        return favoritePokemons ?? []
    }
    
    
    
    
    /// Delete Selected Pokemon from UserDefaults and Resave them
    func deletePokemons(pokemon : FavoritePokemonModel) {

        var currentPokemons = retreivedPokemons()
        if currentPokemons.contains(where: {
            $0.name == pokemon.name
        }) {
            currentPokemons.removeAll(where: {
                $0.name == pokemon.name
            })
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(currentPokemons)
            print(data)
            UserDefaults.standard.set(data, forKey: "favoritePokemonsObject")
        } catch {
            print("Unable to Encode Pokemons (\(error))")
        }
    }
    
    
}
