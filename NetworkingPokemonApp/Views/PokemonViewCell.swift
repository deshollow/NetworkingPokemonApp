//
//  PokemonViewCell.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

//4.2. Настраиваем ячейку в PokemonViewCell

import UIKit

class PokemonViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    //a. Мы будем из основного экрана View, брать один элемент, экземпляр покемона и настраивать
    //ячейку с name и image
    func configur(pokemon: Pokemon) { //b.делаем функцию конфигуратор для наших ячеек
        nameLabel.text = pokemon.name //c.заполняем ячейки именами покемонов
        //d.теперь мы можем использовать экземпляр нашего покемона для доступа к картинке
        //e.смотрим внимательно вложенность по модели
        NetworkManager.shared.fetch(dataType: Character.self, url: pokemon.url) { character in
            NetworkManager.shared.fetchImage(from: character.sprites.other.home.front_default) { data in /*f.берем метод из
                                                                                                          NetworkManager*/
                self.pokemonImageView.image = UIImage(data: data) /*g.у UIImage есть инициализатор data для
                                                                   получения картинки из data*/
            }
        }
    }
}
