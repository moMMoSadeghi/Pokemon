//
//  PokemonDataModel0.swift
//  Pokemon
//
//  Created by iMommo on 08/11/22.
//

import Foundation


struct PokemonDetailsDataModel : Codable {
    let name       : String
    let stats      : [Stats]
    let abilities  : [Ability]
}


struct Stats: Codable {
    let base_stat : Int
}

struct Ability   : Codable {
    let ability  : Species
    let is_hidden : Bool
    let slot     : Int
}

struct Species : Codable {
    let name   : String
}
