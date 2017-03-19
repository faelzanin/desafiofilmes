//
//  HomeSearchFilmsCollectionViewCell.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class HomeSearchFilmsCollectionViewCell: UICollectionViewCell {

    var homeViewController : HomeViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func searchFilmButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchFilmViewController")
        homeViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
