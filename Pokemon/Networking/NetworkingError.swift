//
//  NetworkingError.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import Foundation




enum NetworkingError: Error {
    
    case badUrl
    case badResponse(errorMessage: String)
    case badStatusCode
    case badData
    case unKnown
    
    var errorDescription: String{
        switch self {
        case .badUrl:
            return "ops! someThings went wrong."
        case .badStatusCode:
            return "please check your network connection, and try later!"
        case .badData:
            return "ops! someThings went wrong."
        case .unKnown:
            return "ops! someThings went wrong."
        case .badResponse:
            return "ops! someThings went wrong."
        }
    }
}
