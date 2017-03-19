//
//  EmptyStateCollectionViewCell.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class EmptyStateCollectionViewCell: UICollectionViewCell {

    var homeViewController : HomeViewController!
    
    @IBOutlet weak var messageEmptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
