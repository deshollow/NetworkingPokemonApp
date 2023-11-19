//
//  PokemonViewCell.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

import UIKit

class PokemonViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    
    private let networkingManager = NetworkingManager.shared
    
    func configure(pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        
        NetworkingManager.shared.fetchCharachers(from: pokemon.url) { result in
            switch result {
                
            case .success(let character):
                self.configureImage(character: character)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureImage(character: Character) {
        NetworkingManager.shared.fetchData(from: character.sprites.other.home.front_default) { result in
            switch result {
            case .success(let imageData):
                self.pokemonImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
