//
//  HomeVC.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 21/02/23.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {

    @IBOutlet weak var favCollectionView: UICollectionView!
    @IBOutlet weak var stafTblView: UITableView!
    @IBOutlet weak var staffTblHeightConstraint: NSLayoutConstraint!
    
    var allStaffs = [[String:AnyObject]]()
    var favoriteMovies = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        allStaffs = loadJson("staff_picks")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if getUserDefaultArrayValue(KEY_IS_FAV_MOVIE).count > 0{
            favoriteMovies = [[String:AnyObject]]()
            favoriteMovies = getUserDefaultArrayValue(KEY_IS_FAV_MOVIE)
        }
        setupUI()
    }
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        favCollectionView.register(UINib(nibName: "FavCell", bundle: nil), forCellWithReuseIdentifier: "FavCell")
        favCollectionView.register(UINib(nibName: "ViewAllCell", bundle: nil), forCellWithReuseIdentifier: "ViewAllCell")
        
        self.stafTblView.register(UINib(nibName: "MoviesCell", bundle: nil), forCellReuseIdentifier: "MoviesCell")
        self.favCollectionView.delegate = self
        self.favCollectionView.dataSource = self
        self.stafTblView.delegate = self
        self.stafTblView.dataSource = self
        favCollectionView.reloadData()
        self.stafTblView.reloadData()
        staffTblHeightConstraint.constant = self.stafTblView.contentSize.height
    }
    //MARK: - Button Actions
    
    @IBAction func btnSearchActions(_ sender: UIButton) {
        let VC = AllMoviesVC(nibName: "AllMoviesVC", bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStaffs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as! MoviesCell
        var isFavorite = false
        self.favoriteMovies.filter { favMov in
            if favMov["id"] as? Int == allStaffs[indexPath.row]["id"] as? Int{
                isFavorite = true
            }
            return true
        }
        cell.setupData(data: allStaffs[indexPath.row],isFavorite:isFavorite)
        cell.btnBookmark.tag = indexPath.row
        cell.btnBookmark.addTarget(self,action:#selector(buttonClicked),
                                   for:.touchUpInside)
        cell.imgMovie.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    @objc func buttonClicked(sender:UIButton)
    {
        if favoriteMovies.count == 0{
            favoriteMovies.append(allStaffs[sender.tag])
        }else
        {
            var isFound = false
            for (i,favMov) in self.favoriteMovies.enumerated().reversed(){
                if favMov["id"] as? Int == allStaffs[sender.tag]["id"] as? Int{
                    self.favoriteMovies.remove(at: i)
                    isFound = true
                }
            }
            if !isFound{
                favoriteMovies.append(allStaffs[sender.tag])
            }
        }
        setUserDefaultArrayValue(KEY_IS_FAV_MOVIE, value: favoriteMovies)
        stafTblView.reloadData()
        favCollectionView.reloadData()
    }
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteMovies.count == 0{
            collectionView.setMessage("Your have not favorite any movie yet")
            return 0
        }
        collectionView.removeMessage()
        return favoriteMovies.count+1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == favoriteMovies.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewAllCell", for: indexPath) as! ViewAllCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavCell", for: indexPath) as! FavCell
            if favoriteMovies.count > 0{
                let data = favoriteMovies[indexPath.row]
                if let imageURL = NSURL(string:data["posterUrl"] as? String ?? "") {
                    cell.imfFav.sd_imageIndicator?.startAnimatingIndicator()
                    cell.imfFav.sd_setImage(with: imageURL as URL)
                    cell.layer.cornerRadius = 14
                }
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 270.0
        if indexPath.row == favoriteMovies.count{
            width = 145.0
        }
        return CGSize(width: width, height:collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != favoriteMovies.count{
            let VC = MoviesDetailsVC(nibName: "MoviesDetailsVC", bundle: nil)
            VC.selectedMovies = favoriteMovies[indexPath.row]
            VC.modalPresentationStyle = .fullScreen
            let navController = UINavigationController(rootViewController: VC)
            navController.modalPresentationStyle = .fullScreen
            navController.navigationBar.installBlurEffect()
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
        
    }
}
