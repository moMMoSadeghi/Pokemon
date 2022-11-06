//
//  PokemonPassData.swift
//  Pokemon
//
//  Created by iMommo on 05/11/22.
//

import Foundation



class PokemonPassData {
    
    
//    This method passes the ID of each Pokemon base on the Pokemon's Name
    func changePokemonNameToID(selectedPokemon : String) -> Int {
        switch selectedPokemon {
        case "bulbasaur":
            return 1
        case "ivysaur":
            return 2
        case "venusaur":
            return 3
        case "charmander":
            return 4
        case "charmeleon":
            return 5
        case "charizard":
            return 6
        case "squirtle":
            return 7
        case "wartortle":
            return 8
        case "blastoise":
            return 9
        case "caterpie":
            return 10
        case "metapod":
            return 11
        case "butterfree":
            return 12
        case "weedle":
            return 13
        case "kakuna":
            return 14
        case "beedrill":
            return 15
        case "pidgey":
            return 16
        case "pidgeotto":
            return 17
        case "pidgeot":
            return 18
        case "rattata":
            return 19
        case "raticate":
            return 20
            
        default:
            return 1
        }
    }
}
