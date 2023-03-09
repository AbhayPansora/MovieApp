//
//  FavCell.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 21/02/23.
//

import UIKit

class FavCell: UICollectionViewCell {

    @IBOutlet weak var mainView: CustomView!
    @IBOutlet weak var imfFav: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 14
        imfFav.layer.cornerRadius = 14
    }

}
