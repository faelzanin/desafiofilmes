//
//  Film.swift
//  Desafio
//
//  Created by tqi on 17/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class Film: NSObject, NSCoding  {
    
    var title : String?
    var posterUrl : String?
    var year : Int?
    var imdbID : String?
    var type : String?
    var rated : String?
    var released : String?
    var runtime : String?
    var genre : String?
    var director : String?
    var writer : String?
    var actors : String?
    var plot : String?
    var language : String?
    var country : String?
    var awards : String?
    var metascore : String?
    var imdbRating : String?
    var imdbVotes : String?
    
    override init() {
    }
    
    func dicToFilm(dic: NSDictionary) {
        
        title = dic["Title"] as? String
        posterUrl = dic["Poster"] as? String
        year = Int(dic["Year"] as! String)
        imdbID = dic["imdbID"] as? String
        type = dic["Type"] as? String
        rated = dic["Rated"] as? String
        released = dic["Released"] as? String
        runtime = dic["Runtime"] as? String
        genre = dic["Genre"] as? String
        director = dic["Director"] as? String
        writer = dic["Writer"] as? String
        actors = dic["Actors"] as? String
        plot = dic["Plot"] as? String
        language = dic["Language"] as? String
        country = dic["Country"] as? String
        awards = dic["Awards"] as? String
        metascore = dic["Metascore"] as? String
        imdbRating = dic["imdbRating"] as? String
        imdbVotes = dic["imdbVotes"] as? String
    }
    
    /// NSCoding
    required init(coder aDecoder: NSCoder) {
        
        title = aDecoder.decodeObject(forKey: "Title") as? String
        posterUrl = aDecoder.decodeObject(forKey: "Poster") as? String
        year = aDecoder.decodeObject(forKey: "Year") as? Int
        imdbID = aDecoder.decodeObject(forKey: "imdbID") as? String
        type = aDecoder.decodeObject(forKey: "Type") as? String
        rated = aDecoder.decodeObject(forKey: "Rated") as? String
        released = aDecoder.decodeObject(forKey: "Released") as? String
        runtime = aDecoder.decodeObject(forKey: "Runtime") as? String
        genre = aDecoder.decodeObject(forKey: "Genre") as? String
        director = aDecoder.decodeObject(forKey: "Director") as? String
        writer = aDecoder.decodeObject(forKey: "Writer") as? String
        actors = aDecoder.decodeObject(forKey: "Actors") as? String
        plot = aDecoder.decodeObject(forKey: "Plot") as? String
        language = aDecoder.decodeObject(forKey: "Language") as? String
        country = aDecoder.decodeObject(forKey: "Country") as? String
        awards = aDecoder.decodeObject(forKey: "Awards") as? String
        metascore = aDecoder.decodeObject(forKey: "Metascore") as? String
        imdbRating = aDecoder.decodeObject(forKey: "imdbRating") as? String
        imdbVotes = aDecoder.decodeObject(forKey: "imdbVotes") as? String
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(posterUrl, forKey: "Poster")
        aCoder.encode(year, forKey: "Year")
        aCoder.encode(imdbID, forKey: "imdbID")
        aCoder.encode(type, forKey: "Type")
        aCoder.encode(rated, forKey: "Rated")
        aCoder.encode(released, forKey: "Released")
        aCoder.encode(runtime, forKey: "Runtime")
        aCoder.encode(genre, forKey: "Genre")
        aCoder.encode(director, forKey: "Director")
        aCoder.encode(writer, forKey: "Writer")
        aCoder.encode(actors, forKey: "Actors")
        aCoder.encode(plot, forKey: "Plot")
        aCoder.encode(language, forKey: "Language")
        aCoder.encode(country, forKey: "Country")
        aCoder.encode(awards, forKey: "Awards")
        aCoder.encode(metascore, forKey:"Metascore")
        aCoder.encode(imdbRating, forKey:"imdbRating")
        aCoder.encode(imdbVotes, forKey:"imdbVotes")
    }
    
}
