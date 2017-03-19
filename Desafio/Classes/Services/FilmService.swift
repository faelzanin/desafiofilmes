//
//  FilmService.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit
import Alamofire


class FilmService: NSObject {
    
    var headers: HTTPHeaders?  = nil
    
    class var sharedInstance:FilmService {
        struct Singleton {
            static let instance = FilmService()
        }
        
        return Singleton.instance
    }
    
    
    public func setHeaders()
    {
        self.headers  = [
            "Content-Type": Constants.Header.contentType,
            "Accept": Constants.Header.accept
        ]
    }
    
    public func getFilmsBySearch(_ search: String, onCompletion: @escaping (_ result: NSDictionary?, _ error: NSError?)->() )
    {
        self.setHeaders();
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(Constants.Endpoint.PROD + "?s="+search.replacingOccurrences(of: " ", with: "+"), method: HTTPMethod.get, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response:DataResponse<Any>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                
                let responseObject =  response.result.value as! NSDictionary?
                if responseObject != nil {
                    let responseBool = responseObject?["Response"] as! String
                    if(responseBool == "True") {
                        onCompletion(responseObject, nil)
                    } else {
                        let error = NSError(domain: "AlertErrorFilmNotFound".localized, code: 0, userInfo:nil)
                        onCompletion(nil, error)
                    }
                }
                break
            case .failure(_):
                let responseError = response.result.error as NSError?
                let error = NSError(domain: "AlertErrorDefault".localized, code: (responseError?.code)!, userInfo: responseError?.userInfo)
                onCompletion(nil, error)
                break
            }
        }
        
    }
    
    public func getFilmById(_ imdbID : String, onCompletion: @escaping (_ result: NSDictionary?, _ error: NSError?)->() )
    {
        self.setHeaders();
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(Constants.Endpoint.PROD + "?i="+imdbID+"&plot=full", method: HTTPMethod.get, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response:DataResponse<Any>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result) {
            case .success(_):
                
                let responseObject =  response.result.value as! NSDictionary?
                if responseObject != nil {
                    let responseBool = responseObject?["Response"] as! String
                    if(responseBool == "True") {
                        onCompletion(responseObject, nil)
                    } else {
                        let error = NSError(domain: "AlertErrorFilmNotFound".localized, code: 0, userInfo:nil)
                        onCompletion(nil, error)
                    }
                }
                break
            case .failure(_):
                let responseError = response.result.error as NSError?
                let error = NSError(domain: "AlertErrorDefault".localized, code: (responseError?.code)!, userInfo: responseError?.userInfo)
                onCompletion(nil, error)
                break
            }
        }
        
    }


}
