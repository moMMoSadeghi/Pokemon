//
//  PokemonDataModel.swift
//  Pokemon
//
//  Created by iMommo on 03/11/22.
//

import Foundation



struct DetailsPokemonDataModel : Codable {
    var sprites : PokemonSprites
    var order : Int
}

struct PokemonSprites : Codable {
    var front_default : String?
}
