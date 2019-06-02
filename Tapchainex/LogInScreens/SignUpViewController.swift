//
//  SignUpViewController.swift
//  Tapchainex
//
//  Created by admin on 11/24/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftKeychainWrapper

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginValidationImage: UIImageView!
    @IBOutlet weak var passwordValidationImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        navigationController?.navigationBar.barTintColor = UIColor.white
    
        
        
    }
    

    
    
    func setUpViews() {
        loginField.textColor = UIColor.gray
        passwordField.textColor = UIColor.gray
        loginField.setBottomLine(borderColor: UIColor.gray)
        passwordField.setBottomLine(borderColor: UIColor.gray)
        registerBtn.backgroundColor = UIColor(red: 102/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1)
        registerBtn.applyGradientOrientation(withColours: [UIColor.init(red: 51, green: 51, blue: 255), UIColor.init(red: 102, green: 194, blue: 255)], gradientOrientation: .vertical)
        
        loginField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
    }
    
    @IBAction func dissmissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goBtnClicked(_ sender: Any) {
        
        
        let loginBtn = loginField.text
        let passwordBtn = passwordField.text
        
        
        
        
        if loginBtn!.isEmpty && passwordBtn?.isEmpty == true{
            self.loginValidationImage.image = UIImage(named: "Validation_error")
            
            let alert = UIAlertController(title: "Error", message: "Prease fill out login and password field and ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        let url = "https://tce-api-v2.azurewebsites.net/api/Users/register"
        let params = ["Username": loginBtn, "Password": passwordBtn ]
        _ = try! JSONSerialization.data(withJSONObject: params)
        
        let headers: HTTPHeaders = ["Content-Type": "application/json", "Accept" : "application/json"]
        
        if loginBtn!.isEmpty == false {
            self.loginValidationImage.image = UIImage(named: "Validation_success")
        }
        else{
            self.loginValidationImage.image = UIImage(named: "Validation_error")
            
            let alert = UIAlertController(title: "Error", message: "Prease fill out login field", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        if passwordBtn!.isEmpty == false {
            self.passwordValidationImage.image = UIImage(named: "Validation_success")
            
        }
        else{
            self.passwordValidationImage.image = UIImage(named: "Validation_error")
            
            let alert = UIAlertController(title: "Error", message: "Prease fill out password field", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        Alamofire.request(url, method: .post, parameters: params as Parameters, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            switch response.result {
            case .success:
             
                let alert = UIAlertController(title: "Error", message: response.result.value.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
              // let saveUserId: Bool = KeychainWrapper.standard.set(5, forKey: "Id")
               //let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "Id")
               // print(removeSuccessful)
              
                
            case .failure(let error):
                print("ERROR with '\(error)")
            }
            
            
            
            
        }
//        DispatchQueue.main.async
//            {
//                let homePage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                let appDelegate = UIApplication.shared.delegate
//                appDelegate?.window??.rootViewController = homePage
//        }
    }
    
    
    
    
    // Alert view and indicators
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
}
