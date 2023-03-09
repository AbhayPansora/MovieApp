//
//  MoviesDetailsVC.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 22/02/23.
//
import Foundation
import UIKit
import AARatingBar
import SDWebImage

class MoviesDetailsVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var imgMovie: CustomImageView!
    @IBOutlet weak var viewRatting: AARatingBar!
    @IBOutlet weak var lblMovieDateDuration: UILabel!
    @IBOutlet weak var lblMoviewName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var vwGenres1: CustomView!
    @IBOutlet weak var lblGenres1: UILabel!
    
    @IBOutlet weak var vwGenres2: CustomView!
    @IBOutlet weak var lblGenres2: UILabel!
    
    @IBOutlet weak var vwGenres3: CustomView!
    @IBOutlet weak var lblGenres3: UILabel!
    
    @IBOutlet weak var lblOverview: UILabel!
    
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblEwvenue: UILabel!
    @IBOutlet weak var lblLunguage: UILabel!
    @IBOutlet weak var lblRatting: UILabel!
    
    //MARK: - Declaration
    var selectedMovies = [String:AnyObject]()
    
    //MARK: - Views Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupData()
        //addBlurEffect()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
       /* let editImage    = UIImage(named: "ic_close")!
        let searchImage  = UIImage(named: "ic_bookmark_fav")!
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(self.dismissMe))
        let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(self.dismissMe)) ic_close_transferent
        self.navigationController?.navigationItem.rightBarButtonItems = [editButton, searchButton]*/
        let favUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_bookmark_fav"), style: .plain, target: self, action: #selector(self.clickButton))
        let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_close_transferent"), style: .plain, target: self, action: #selector(self.clickButton))
        //self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        self.navigationItem.rightBarButtonItems = [testUIBarButtonItem, favUIBarButtonItem]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imgMovie.layer.cornerRadius = 14
    }
    @objc func clickButton(){
        self.dismiss(animated: true)
    }
    func setupData(){
        if let imageURL = NSURL(string:selectedMovies["posterUrl"] as? String ?? "") {
            imgMovie.sd_imageIndicator?.startAnimatingIndicator()
            imgMovie.sd_setImage(with: imageURL as? URL)
            self.imgMovie.layer.cornerRadius = 14
        }
        self.imgMovie.layer.cornerRadius = 14
        viewRatting.value = selectedMovies["rating"] as? CGFloat ?? 0.0
        let hm = Double(selectedMovies["runtime"] as? Int ?? 0)/60.0
        let movieTime = hm.splitIntoParts(decimalPlaces: 2, round: true)
        lblMovieDateDuration.text = "\(formattedDateFromString(dateString: selectedMovies["releaseDate"] as? String ?? "", withFormat: "dd.MM.yyyy") ?? "") - \(movieTime.leftPart)h \(movieTime.rightPart)m"
        lblMoviewName.text = selectedMovies["title"] as? String
        lblYear.text = "("+"\(formattedDateFromString(dateString: selectedMovies["releaseDate"] as? String ?? "", withFormat: "yyyy") ?? "")"+")"
        let genres = selectedMovies["genres"] as? [String]
        if genres?.count ?? 0 >= 3{
            lblGenres1.text = genres?[0] ?? ""
            lblGenres2.text = genres?[1] ?? ""
            lblGenres3.text = genres?[2] ?? ""
        }else if genres?.count ?? 0 == 2{
            vwGenres3.isHidden = true
            lblGenres1.text = genres?[0] ?? ""
            lblGenres2.text = genres?[1] ?? ""
        }else if genres?.count ?? 0 == 1{
            vwGenres2.isHidden = true
            vwGenres3.isHidden = true
            lblGenres1.text = genres?[0] ?? ""
        }else {
            vwGenres1.isHidden = true
            vwGenres2.isHidden = true
            vwGenres3.isHidden = true
        }
        lblOverview.text = selectedMovies["overview"] as? String
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        let tempB = selectedMovies["budget"] as? Int ?? 0
        lblBudget.text = "$\(tempB.formattedWithSeparator)"
        let tempR = selectedMovies["revenue"] as? Int ?? 0
        lblEwvenue.text = "$\(tempR.formattedWithSeparator)"
        if let identifier = (Locale.current as NSLocale).displayName(forKey: .identifier, value: "\(selectedMovies["language"] as? String ?? "en")") {
            lblLunguage.text = "\(identifier)"
        }
        
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .up
        
        lblRatting.text = "\(String(describing: formatter.string(from: NSNumber(value: selectedMovies["rating"] as? Double ?? 0.0))!))"+"(\(selectedMovies["reviews"] as? Int ?? 0))"
    }
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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
    func twoDecimals(number: Float) -> Float{
        let stringValue = String(format: "%.2f", number)
        return Float(stringValue)!
    }
    func addBlurEffect() {
        let bounds = self.navigationController?.navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds ?? CGRect.zero
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)

        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in the above code to add effects to the custom view.
    }

}
