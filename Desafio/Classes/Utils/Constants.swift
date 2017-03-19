//
//  Constants.swift
//  Desafio
//
//  Created by rafaelzanin on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class Constants: NSObject {

    class Endpoint {
        static let PROD = "http://www.omdbapi.com/"
    }
    
    class Header {
        static let contentType =  "application/json";
        static let accept =  "application/json";
    }
    
    class Cache {
        static let filmsKey = "films_key"
        static let filmsCacheKey = "films_cache_key"
    }
    
}
