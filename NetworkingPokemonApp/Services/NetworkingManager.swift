//
//  NetworkingManager.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

//2.1. Вторым действием после модели, идем в NetworkManager и описываем методы в классе. Тут есть 2 метода, дублировать или чз generic

import Foundation

enum NetworkError: Error {
case invalidURL
case noData
case decodingError
}

enum List: String {
case url = "https://pokeapi.co/api/v2/pokemon"
}

class NetworkManager { //a. сетевой сервисный слой, ничего не должен знать о UI
    static let shared = NetworkManager() //b. опрописываем singleton
    
    //2.2. Первый метод, менее профессиональный, но тогда его придется дублировать для работы с Image нашего покемона
    
    //    //а.тк работаем с сетью, нам нужно данные возвращать без ожидания, асинхронно в блоке замыкания
    //    func fetchPokemons(url: String, completion: @escaping([Pokemon]) -> Void) { //b. используем убегающее замыкание
    //        guard let url = URL(string: url) else {return} //c. проверяем ссылку на валидность, которую передадим в метод
    //        //d. запускаем URL-сессию, with валидный url, в комплишен возвращаем data, _ , ошибку
    //        URLSession.shared.dataTask(with: url) {data, _, error in
    //            //e. data опциональная, мы ее должны извлечь с помощью опциональной привязки
    //            guard let data else { //то же самое что guard let data = data
    //                return
    //            }
    //            /*f. тк сервер хранит все в бинарке, нам нужно словарик с JSON разложить по модели. Decoder помогает разложить все по свойствам структуры. Всегда используем для этого do catch*/
    //            do {
    //                let decoder = JSONDecoder()
    //                let pokemonApp = try decoder.decode(PokemonApp.self, from: data) /*g.self тк хотим получить на выходе тип данных модели, а не экземпляр. На основе этого типа данных, должны сформировать экземпляр модели. Дальше его получаем в ViewController-e*/
    //                DispatchQueue.main.async { //h. для того чтобы правильно влиться в основной поток, делаем это асинхронно через DispatchQueue
    //                    completion(pokemonApp.results) //i. мы берем у основной модели только results, массив словарей другими словами [Results]
    //                }
    //            } catch {
    //                print(error)
    //            }
    //        }.resume() //j. обязательно используем .resume()
    //    }
    
    //2.3. Второй метод универсальный через generic, определяем его через <T>
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(T) -> Void) { //a. T - подписываем под протокол Decodable
        guard let url = URL(string: url) else { return } //b. далее по аналогии с первым методом, но везде используем T.Type
        URLSession.shared.dataTask(with: url) {data, _, error in
            
            guard let data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(type)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    //4.3. Возвращаемся в NetworkManager. Мы должны сделать метод по загрузке картинки, которую мы будем использовать в 4.2 PokemonViewCell configur
    
    func fetchImage(from url: String, completion: @escaping(Data) -> Void) { //a. используем completion с убегающим замыканием
        guard let url = URL(string: url) else { return } //b. проверяем на валидность url адрес
        DispatchQueue.global().async { //c.выходим в глобал поток, чтобы картинки асинхронно подргружались
            guard let imageData = try? Data(contentsOf: url) else { return } /*d. инициализатор Data contentsOf
                                                                              - занимается загрузкой даты из сети*/
            DispatchQueue.main.async { //e.после этого выходим в main поток, когда данные будут доступны
                completion(imageData) //f. imageData будет по сути Data
            }
        }
    }
    
    private init() {}
    
}
