//
//  SignUpVC.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 18/02/23.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var imgProfile: CustomImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var lblPwd: UILabel!
    @IBOutlet weak var txtCPwd: UITextField!
    @IBOutlet weak var lblCPwd: UILabel!
    
    
    //MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    //MARK: - Custom Methods
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        [txtName,txtEmail,txtPwd,txtCPwd].forEach { txt in
            txt?.delegate = self
        }
        [lblEmail,lblPwd,lblCPwd].forEach { lbl in
            lbl?.isHidden = true
        }
    }
    func setValidation() -> Bool{
        var isValid = true
        if txtEmail.text == ""{
            isValid = false
            lblEmail.isHidden = false
        }
        if txtPwd.text == ""{
            isValid = false
            lblPwd.isHidden = false
        }
        if txtCPwd.text == ""{
            isValid = false
            lblCPwd.text = "Please enter confirm password"
            lblCPwd.isHidden = false
        }
        if txtCPwd.text != txtPwd.text{
            isValid = false
            lblCPwd.text = "Password doesn't match"
            lblCPwd.isHidden = false
        }
        
        return isValid
    }
    //MARK: - Buton Action Methods
    @IBAction func btnSignUpAction(_ sender: Any) {
        if setValidation(){
            setBoolUserDefaultValue(KEY_IS_USER_LOGGED_IN, value: true)
            let VC = HomeVC(nibName: "HomeVC", bundle: nil)
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnPwdEyeAction(_ sender: Any) {
        if txtPwd.isSecureTextEntry{
            txtPwd.isSecureTextEntry = false
        }else{
            txtPwd.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnCPwdEyeAction(_ sender: Any) {
        if txtCPwd.isSecureTextEntry{
            txtCPwd.isSecureTextEntry = false
        }else{
            txtCPwd.isSecureTextEntry = true
        }
    }
}
extension SignUpVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtEmail{
            lblEmail.isHidden = false
        }else if textField == txtPwd{
            lblPwd.isHidden = false
        }else if textField == txtCPwd{
            lblCPwd.isHidden = false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        if textField == txtEmail{
            if resultString.isEmpty{
                lblEmail.isHidden = false
            }else{
                lblEmail.isHidden = true
            }
        }else if textField == txtPwd{
            if resultString.isEmpty{
                lblPwd.isHidden = false
            }else{
                lblPwd.isHidden = true
            }
        }else if textField == txtCPwd{
            if resultString.isEmpty{
                lblCPwd.text = "Please enter confirm password"
                lblCPwd.isHidden = false
            }else{
                lblCPwd.isHidden = true
            }
        }
        return true
    }
}
