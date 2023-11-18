//
//  PokemonListViewController.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

/*3.1. Нам нужно сделать так, чтобы экземпляр из NetworkManager, в нашем случае pokemonApp попал к нам во ViewController.
Далее два метода описанные в 3.2 и 3.3 */

import UIKit

class PokemonListViewController: UITableViewController {
    
    var pokemons: [Pokemon] = [] //a. создаем пустой массив типа [Pokemon], который будем наполнять
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
    }
    //3.2. Первый вариант, если мы не использовали generic в методах класса NetworkManager
    
    //    private func fetchPokemons() { //a. обращаемся к методам из нашего класса NetworkManager, создаем приватную функцию fetchPokemons()
    //        NetworkManager.shared.fetchPokemons(url: List.url.rawValue) { pokemons in
    //            self.pokemons = pokemons //b. обращаемся через self. Наполняем наш массив pokemons и переопределяем в блоке замыкания.
    //            self.tableView.reloadData() /*c. тк нам нужен наполненный массив а не пустой,
    //                                         запускаем reloadData. Этот метод заново запускает numberOfRowsInSections, смотрит на массив,
    //                                         берет массив уже с полными данными и загружает дальше все остальные моменты*/
    //        }
    //
    //    }
    //3.3. Второй вариант, если мы использовали generic в методах класса NetworkManager
    
    private func fetchPokemons() {
        NetworkManager.shared.fetch(dataType: PokemonApp.self ,url: List.url.rawValue) { pokemonApp in
            self.pokemons = pokemonApp.results
            self.tableView.reloadData()
        }
    }
}
    //4.1. Мы спарсили данные, декодировали, получили массив с ними, теперь их нужно отобразить
    
    extension PokemonListViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            pokemons.count //a. определяем количество ячеек
        }
        //b. кастим до нашей кастомной ячейки PokemonViewCell
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonViewCell
            else { return UITableViewCell() } /*c.возвращаем пустую ячейку, если
                                               не получится создать  экземпляр PokemonViewCell*/
            //d. теперь нам нужно достать один экземпляр из массива. Делаем по indexPath
            let pokemon = pokemons[indexPath.row] //e.indexPath это структура, выбираем row тк нужна ячейка
            //f. определяем метод для формирования ячейки (его мы опишем в 4.2 PokemonViewCell)
            cell.configur(pokemon: pokemon)
            
            return cell
        }
    }

