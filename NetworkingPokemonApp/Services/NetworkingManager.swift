//
//  NetworkingManager.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

import Foundation
import Alamofire

enum List: String {
    case url = "https://pokeapi.co/api/v2/pokemon"
    
}

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchPokemons(from url: String, completion: @escaping(Result<[Pokemon], AFError>) -> Void) {
        guard let url = URL(string: url) else {print("url"); return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let pokemons = PokemonApp.getPokemons(from: value)
                    //                    print(value)
                    completion(.success(pokemons))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCharachers(from url: String, completion: @escaping(Result<Character, AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                     let character = Character.getCharacter(from: value)
                    completion(.success(character ?? Character(characterDict: [:])  ) )
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        guard let url = URL(string: url) else {print("url"); return }
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    print(imageData)
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
}
