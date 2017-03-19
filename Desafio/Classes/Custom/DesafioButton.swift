//
//  DesafioButton.swift
//  Desafio
//
//  Created by rafaelzanin on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

@IBDesignable
class DesafioButton: UIButton {
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
