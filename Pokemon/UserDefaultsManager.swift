//
//  UserDefaultsManager.swift
//  Pokemon
//
//  Created by iMommo on 10/11/22.
//

import Foundation



class UserDefaulsManager : Codable {
    
    
    
//    func setObject<Object>(_ object: Object, forKey: String) where Object: Encodable
//    {
//        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(object)
//            set(data, forKey: forKey)
//            synchronize()
//        } catch let encodeErr {
//            print("Failed to encode object:", encodeErr)
//        }
//    }
//
//    func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable
//    {
//        guard let data = data(forKey: forKey) else { return nil }
//        let decoder = JSONDecoder()
//        do {
//            let object = try decoder.decode(type, from: data)
//            return object
//        } catch let decodeError{
//            print("Failed to decode object:" , decodeError)
//            return nil
//        }
//    }
    
    


    func savedPokemons(pokemon : [FavoritePokemonModel]) {
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

         var favoritePokemons : [FavoritePokemonModel]!
        if let data = UserDefaults.standard.data(forKey: "favoritePokemonObject") {
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([FavoritePokemonModel].self, from: data)
                favoritePokemons = pokemons
            } catch {
                print("Unable to Decode Pokemons (\(error))")
            }
        }
         return favoritePokemons
    }
}


//how to save an array objects into userDefaults 
