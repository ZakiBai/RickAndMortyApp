//
//  RickAndMorty.swift
//  RickAndMortyApp
//
//  Created by Zaki on 05.06.2023.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let next: URL?
    let prev: URL?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: URL
    let episode: [URL]
    let url: String
    
    var description: String {
        """
        Name: \(name)
        Status: \(status)
        Species: \(species)
        Gender: \(gender)
        Origin: \(origin.name)
        Location: \(location.name)
        """
    }
}

struct Location: Decodable {
    let name: String
}

enum RickAndMortyAPI {
    case baseURL
    
    var url: URL {
        switch self {
        case .baseURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}
