//
//  FilmController.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

enum FilmServices : Int {
    case getFilmById
    case getFilmsBySearch
    
}

@objc protocol FilmControllerDelegate {
   
    @objc optional func getFilmsBySearchDidFinishWithSuccess(response: NSMutableArray)
    @objc optional func getFilmsBySearchDidFinishWithError(error: NSError)
    
    @objc optional func getFilmByIdDidFinishWithSuccess(response: Film)
    @objc optional func getFilmByIdDidFinishWithError(error: NSError)
}


class FilmController: NSObject {
    
    var delegate: FilmControllerDelegate?
    
    override init(){
        
    }
    
    class var sharedInstance:FilmController {
        struct Singleton {
            static let instance = FilmController()
        }
        
        return Singleton.instance
    }
    
    
    func getFilmsBySearch(search : String){
        
        FilmService.sharedInstance.getFilmsBySearch(search) { (response, error) in
            
            if(error == nil) {
                self.processSuccessResponse(successResponse: response, forService: .getFilmsBySearch)
            } else {
                self.processErrorResponse(errorResponse: error, forService: .getFilmsBySearch)
            }
            
        }
    }
    
    func getFilmById(imdbID : String){
        
        FilmService.sharedInstance.getFilmById(imdbID) { (response, error) in
            
            if(error == nil) {
                self.processSuccessResponse(successResponse: response, forService: .getFilmById)
            } else {
                self.processErrorResponse(errorResponse: error, forService: .getFilmById)
            }
            
        }
    }
    
    
    func processSuccessResponse(successResponse: NSDictionary?, forService service: FilmServices) {
      
        
        switch service {
        case .getFilmsBySearch:
            
            let responseArray : NSArray = successResponse?["Search"] as! NSArray
            let listFilms : NSMutableArray = NSMutableArray()
            for filmObject in responseArray as! [NSDictionary] {
                let film = Film()
                film.dicToFilm(dic: filmObject)
                listFilms.add(film)
            }
            
            if (self.delegate != nil) {
                delegate?.getFilmsBySearchDidFinishWithSuccess!(response: listFilms)
            }
            
            break
        case .getFilmById:
            let film = Film()
            film.dicToFilm(dic: successResponse!)
            
            if (self.delegate != nil) {
                delegate?.getFilmByIdDidFinishWithSuccess!(response: film)
            }
            break
      
            
        }
    }
    
    func processErrorResponse(errorResponse: NSError?, forService service: FilmServices) {
      
        switch service {
        case .getFilmsBySearch:
            
            if (self.delegate != nil) {
                delegate?.getFilmsBySearchDidFinishWithError!(error: errorResponse!)
            }
            
            break
        case .getFilmById:
            if (self.delegate != nil) {
                delegate?.getFilmByIdDidFinishWithError!(error: errorResponse!)
            }
            
            break
      
            
        }
        
    }
    
}
    
