//
//  CacheUtil.swift
//  Desafio
//
//  Created by tqi on 19/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit
import AwesomeCache

class CacheUtil: NSObject {

    class var sharedInstance:CacheUtil {
        struct Singleton {
            static let instance = CacheUtil()
        }
        return Singleton.instance
    }
    
    
    private func saveFilms(films: NSMutableArray){
        
        do {
            let cache = try Cache<NSMutableArray>(name: Constants.Cache.filmsCacheKey)
            cache.setObject(films, forKey: Constants.Cache.filmsKey)
        } catch _ {
            print("Something went wrong :(")
        }
    }
    
    public func getFilms() -> NSMutableArray? {
        var films : NSMutableArray? 
        
        do {
            let cache = try Cache<NSMutableArray>(name: Constants.Cache.filmsCacheKey)
            films = cache[Constants.Cache.filmsKey]
        } catch _ {
            print("Something went wrong :(")
        }
        
        if(films != nil) {
            return films
        }
        
        return NSMutableArray()
    }
    
    public func getFilmByTitle(title: String) -> Film? {
        var film : Film? = nil
        
        let films : NSArray? = getFilms() 
        
        if(films != nil) {
            for filmFromArray in films as! [Film] {
                if(filmFromArray.title == title) {
                    film = filmFromArray
                }
            }
        }
        
        return film
    }
    
    public func removeFilm(film: Film) {
        
        let films = getFilms()! as NSArray
        var indexToRemove : Int = -1
        for filmFromArray in films as! [Film] {
            if(filmFromArray.title == film.title) {
                indexToRemove = films.index(of: filmFromArray)
            }
        }
        
        if(indexToRemove != -1) {
            let filmsToSave = getFilms()
            filmsToSave?.removeObject(at: indexToRemove)
            saveFilms(films: filmsToSave!)
        }
        
    }
    
    public func saveFilm(film: Film) {
        let films = getFilms()
        films?.add(film)
        saveFilms(films: films!)
    }
    
}
