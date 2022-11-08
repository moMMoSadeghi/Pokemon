//
//  PokemonDataModel0.swift
//  Pokemon
//
//  Created by iMommo on 08/11/22.
//

import Foundation


struct PokemonDetailsDataModel : Codable {
    let name            : String
    let stats           : [Stats]
}


struct Stats: Codable {
    let base_stat   : Int
}
