//
//  MoviesCell.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 18/02/23.
//

import UIKit
import AARatingBar
import SDWebImage

class MoviesCell: UITableViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMoveiName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var rattingView: AARatingBar!
    @IBOutlet weak var btnBookmark: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgMovie.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupData(data:[String:AnyObject],isFavorite:Bool){
        if let imageURL = NSURL(string:data["posterUrl"] as? String ?? "") {
            imgMovie.sd_imageIndicator?.startAnimatingIndicator()
            imgMovie.sd_setImage(with: imageURL as? URL)
            self.imgMovie.layer.cornerRadius = 10
        }
        lblMoveiName.text = data["title"] as? String
        lblYear.text = formattedDateFromString(dateString: data["releaseDate"] as? String ?? "", withFormat: "yyyy")
        rattingView.value = data["rating"] as? CGFloat ?? 0.0
        btnBookmark.setImage(UIImage(named: "ic_bookmark"), for: .normal)
        if isFavorite{
            btnBookmark.setImage(UIImage(named: "ic_bookmark_fav"), for: .normal)
        }
    }
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
}
