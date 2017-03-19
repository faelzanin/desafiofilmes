//
//  FilmSearchedCollectionViewCell.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class FilmSearchedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    private let highlightedColor : UIColor! = UIColor.gray
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isHighlighted: Bool {
        willSet {
            contentView.backgroundColor = newValue ? highlightedColor : UIColor.clear
        }
    }
    override var isSelected: Bool {
        willSet {
            contentView.backgroundColor = newValue ? highlightedColor : UIColor.clear
        }
    }

}
