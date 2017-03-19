//
//  AlertMessage.swift
//  Desafio
//
//  Created by tqi on 19/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class AlertMessage : NSObject {
    
    class var shared: AlertMessage {
        struct Static {
            static let instance: AlertMessage = AlertMessage()
        }
        return Static.instance
    }
    
    
    public func show(title: String, message: String, viewController: UIViewController, dismissViewController: Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { ( UIAlertAction) in
            if dismissViewController {
                _ = viewController.navigationController?.popViewController(animated: true)
            }
        }
        
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
