//
//  Pokemon.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

import Foundation

struct PokemonApp: Codable {
    let results: [Pokemon]
    
    init(results: [Pokemon]) {
        self.results = results
    }
    
    static func getPokemons(from value: Any) -> [Pokemon] {
        guard let pokemonData = value as? [String: Any] else { return [] }
        guard let results = pokemonData["results"] as? [[String: Any]] else { return [] }

        
        var pokemons = [Pokemon]()
        
        for pokemon in results {
            pokemons.append(Pokemon(pokemonData: pokemon))
        }
        return pokemons
    }
}

struct Pokemon: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(pokemonData: [String: Any]){
        self.name = pokemonData["name"] as? String ?? ""
        self.url = pokemonData["url"] as? String ?? ""
    }
}

struct Character: Codable {
    let sprites: Sprites
    
    init(characterDict: [String: Any]) {
        let spritesDict = characterDict["sprites"] as? [String: Any] ?? [:]
            self.sprites = Sprites(spritesDict: spritesDict)
        }
    
        static func getCharacter(from value: Any) -> Character? {
            guard let characterData = value as? [String: Any] else { return nil }
            
            return Character(characterDict: characterData)
        }

    }

struct Sprites: Codable {
    let other: Home
    
    init(spritesDict: [String: Any]) {
         let otherDict = spritesDict["other"] as? [String: Any] ?? [:]
            self.other = Home(homeDict: otherDict)
        
        }
}

struct Home: Codable {
    let home: Front
    
    init(homeDict: [String: Any]) {
        let homeDict = homeDict["home"] as? [String: Any] ?? [:]
        self.home = Front(value: homeDict)
    }
}

struct Front: Codable {
    let front_default: String
    
    init(value: [String: Any]) {
        self.front_default = value["front_default"] as? String ?? ""
    }
}


