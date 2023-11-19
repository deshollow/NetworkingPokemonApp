//
//  PokemonListViewController.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

import UIKit
import Alamofire

final class PokemonListViewController: UITableViewController {
    
   private var pokemons: [Pokemon] = []
    private let networkingManager = NetworkingManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
        

    }
    
    private func fetchPokemons() {
        NetworkingManager.shared.fetchPokemons(from: List.url.rawValue) { [unowned self] result in
            
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension PokemonListViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            pokemons.count
            
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
            guard let cell = cell as? PokemonViewCell else { return UITableViewCell() }
            let pokemon = pokemons[indexPath.row]
            
            cell.configure(pokemon: pokemon)
        
            cell.selectionStyle = .none
            return cell
        }
    }
