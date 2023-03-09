//
//  AllMoviesVC.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 18/02/23.
//

import UIKit

class AllMoviesVC: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!    
    @IBOutlet weak var tblMovies: UITableView!
    
    var allMovies = [[String:AnyObject]]()
    var filteredMovies = [[String:AnyObject]]()
    var favoriteMovies = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        allMovies = loadJson("movies")
        if getUserDefaultArrayValue(KEY_IS_FAV_MOVIE).count > 0{
            favoriteMovies = getUserDefaultArrayValue(KEY_IS_FAV_MOVIE)
        }
        setupUI()
    }
    func setupUI(){
        self.tblMovies.register(UINib(nibName: "MoviesCell", bundle: nil), forCellReuseIdentifier: "MoviesCell")
        //self.tblMovies.register(MoviesCell.self, forCellReuseIdentifier: "MoviesCell")
        self.tblMovies.delegate = self
        self.tblMovies.dataSource = self
        self.txtSearch.delegate = self
        self.tblMovies.reloadData()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension AllMoviesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredMovies.count > 0{
            return filteredMovies.count
        }
        return allMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as! MoviesCell
        if filteredMovies.count > 0{
            var isFavorite = false
            if self.favoriteMovies.contains (where: {$0["id"] as? String == filteredMovies[indexPath.row]["id"] as? String}) {
                isFavorite = true
            }
            cell.setupData(data: filteredMovies[indexPath.row],isFavorite:isFavorite)
        }else{
            var isFavorite = false
            self.favoriteMovies.filter { favMov in
                if favMov["id"] as? Int == allMovies[indexPath.row]["id"] as? Int{
                    isFavorite = true
                }
                return true
            }
            cell.setupData(data: allMovies[indexPath.row],isFavorite:isFavorite)
        }
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
            if filteredMovies.count > 0{
                favoriteMovies.append(filteredMovies[sender.tag])
            }else{
                favoriteMovies.append(allMovies[sender.tag])
            }
            
        }else
        {
            if filteredMovies.count > 0{
                var isFound = false
                for (i,favMov) in self.favoriteMovies.enumerated().reversed(){
                    if favMov["id"] as? Int == filteredMovies[sender.tag]["id"] as? Int{
                        self.favoriteMovies.remove(at: i)
                        isFound = true
                    }
                }
                if !isFound{
                    favoriteMovies.append(filteredMovies[sender.tag])
                }
            }else{
                var isFound = false
                for (i,favMov) in self.favoriteMovies.enumerated().reversed(){
                    if favMov["id"] as? Int == allMovies[sender.tag]["id"] as? Int{
                        self.favoriteMovies.remove(at: i)
                        isFound = true
                    }
                }
                if !isFound{
                    favoriteMovies.append(allMovies[sender.tag])
                }
            }
        }
        setUserDefaultArrayValue(KEY_IS_FAV_MOVIE, value: favoriteMovies)
        tblMovies.reloadData()
    }
}
extension AllMoviesVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        filteredMovies.removeAll()
        filteredMovies = allMovies.filter({($0["title"] as! String).lowercased().contains(resultString.lowercased())})
        tblMovies.reloadData()
        return true
    }
}
