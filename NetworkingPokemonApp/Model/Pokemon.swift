//
//  Pokemon.swift
//  NetworkingPokemonApp
//
//  Created by deshollow on 15.11.2023.
//

//1.0. Всегда начинаем с создания модели, первое действие

import Foundation

struct PokemonApp: Decodable { //a.п
    let results: [Pokemon] //массив, тк структура Pokemon содержит массив данных
}

struct Pokemon: Decodable { //b.если бы наоборот преобразовывать из модели в data, то подписывали бы под Encodable
    let name: String
    let url: String
}

struct Character: Decodable { //c.далее далаем вложенность других структур
    let sprites: Sprites
}

struct Sprites: Decodable {
    let other: Home
}

struct Home: Decodable {
    let home: Front
}

struct Front: Decodable {
    let front_default: String
}

//+инфо:
//В NetworkManager при захвате complition в убегающем замыкании, мы будем брать именно [Pokemon] а не [PokemonApp]
//Тк у нас основная модель PokemonApp внутри которой лежит массив результатов [Pokemon]
//Как работает система парсинга decoder:
//Он смотрит на нашу модель, берет тип данных который мы декодируем PokemonApp.self и проверят
//Сможет ли он свой словарь который находится на сервере, переложить на нашу модель. Ок results: и кладет в него массив с другими словарями
//[Pokemon]. Именно это и есть массив словарей
