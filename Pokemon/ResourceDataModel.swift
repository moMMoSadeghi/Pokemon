//
//  ResourceModel.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import Foundation


struct ResourceDataModel : Codable {
    var count : Int
    var next : String
    var previous : String?
    var results : [PokemonDataModel]
}
