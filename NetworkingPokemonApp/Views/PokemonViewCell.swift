//
//  PokemonViewCell.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

//4.2) Настраиваем ячейку

import UIKit

class PokemonViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    //1. Мы будем из основного экрана View, брать один элемент, экземпляр покемона и настраивать
    //ячейку с name и image
    func configur(pokemon: Pokemon) { //2.делаем функцию конфигуратор для наших ячеек
        nameLabel.text = pokemon.name //3.заполняем ячейки именами покемонов
        //4.теперь мы можем использовать экземпляр нашего покемона для доступа к картинке
        //5.смотрим внимательно вложенность по модели
        NetworkManager.shared.fetch(dataType: Character.self, url: pokemon.url) { character in
            NetworkManager.shared.fetchImage(from: character.sprites.other.home.front_default) { data in /*6.берем метод из
                                                                                                          NetworkManager*/
                self.pokemonImageView.image = UIImage(data: data) /*7.у UIImage есть инициализатор data для
                                                                   получения картинки из data*/
            }
        }
    }
}
