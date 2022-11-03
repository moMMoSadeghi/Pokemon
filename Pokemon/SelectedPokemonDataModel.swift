//
//  PokemonSelected.swift
//  Pokemon
//
//  Created by iMommo on 03/11/22.
//

import Foundation



struct SelectedPokemonDataModel : Codable {
    var sprites : PokemonSprites
    var weight : Int
}


struct PokemonSprites : Codable {
    var front_default : String
}
