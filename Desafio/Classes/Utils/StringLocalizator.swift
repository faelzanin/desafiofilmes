//
//  StringLocalizator.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit


import Foundation

private class StringLocalizator {
    
    static let sharedInstance = StringLocalizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Localizable", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }()
    
    func localize(string: String) -> String {
        let localizedString = (localizableDictionary.value(forKey: string)! as AnyObject).value(forKey: "value")
        
        return localizedString as! String
    }
}

extension String {
    var localized: String {
        return StringLocalizator.sharedInstance.localize(string: self)
    }
}

