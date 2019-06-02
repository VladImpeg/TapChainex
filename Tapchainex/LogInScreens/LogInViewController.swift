//
//  LogInViewController.swift
//  Tapchainex
//
//  Created by admin on 11/23/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

import SwiftKeychainWrapper



class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField:  UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginValidationImage: UIImageView!
    @IBOutlet weak var passwordValidationImage: UIImageView!
    @IBOutlet weak var liginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
          navigationController?.navigationBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    
    

    
    
    func setView() {
        liginBtn.backgroundColor = UIColor(red: 102/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1)
        liginBtn.applyGradientOrientation(withColours: [UIColor.init(red: 51, green: 51, blue: 255), UIColor.init(red: 102, green: 194, blue: 255)], gradientOrientation: .vertical)
      
        usernameTextField.textColor = UIColor.gray
        passwordTextField.textColor = UIColor.gray
        usernameTextField.setBottomLine(borderColor: UIColor.gray)
        passwordTextField.setBottomLine(borderColor: UIColor.gray)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func forgotPassDidTapped(_ sender: Any) {
        let forgotPass = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = forgotPass
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
    
        
        
        let userName = usernameTextField.text
        let userPassword = passwordTextField.text
        
        if userName!.isEmpty && userPassword?.isEmpty == true{
            self.loginValidationImage.image = UIImage(named: "Validation_error")
            
            let alert = UIAlertController(title: "Error", message: "Prease fill out login and password field and ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        let url = "https://tce-api-v2.azurewebsites.net/api/Users"
        let params = ["Username": userName, "Password": userPassword]
        
        
        let headers: HTTPHeaders = ["Content-Type": "application/json", "Accept" : "application/json"]
    
        

        
        
        Alamofire.request(url+"/authenticate", method:.post, parameters: params as Parameters,encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            // validation fields
         
            
            if userName!.isEmpty == false {
                self.loginValidationImage.image = UIImage(named: "Validation_success")
            }
            else{
                self.loginValidationImage.image = UIImage(named: "Validation_error")
                
                let alert = UIAlertController(title: "Error", message: "Prease fill out login field", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            if userPassword!.isEmpty == false {
                self.passwordValidationImage.image = UIImage(named: "Validation_success")
                
            }
            else{
                self.passwordValidationImage.image = UIImage(named: "Validation_error")
                
                let alert = UIAlertController(title: "Error", message: "Prease fill out password field", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
         
            // end of validation
            
            
            switch response.result {
            case .success:
               
              
                
                guard let JSONToken = response.result.value as? [String:Any],
                    
                    let token = JSONToken["Token"] as? String else {
                        print("Could not parse values")
                        return
                }
                guard let JSONUser = response.result.value as? [String:Any],
               let userId = JSONUser["Id"] as? Int else {
                print("Could not parse values")
                return
               }
               
               let saveAccesssToken: Bool = KeychainWrapper.standard.set(token, forKey: "Token")
               let saveUserId: Bool = KeychainWrapper.standard.set(userId, forKey: "Id")
               print("The access token save result: \(saveAccesssToken)")
               print("The Id save result: \(saveUserId)")
               if (token.isEmpty)
               {
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                return
                }
               
            
               DispatchQueue.main.async
                {
                    
                
                    
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = homePage
                }
                
            case .failure(let error):
                print("ERROR with '\(error)")
                let alertController = UIAlertController(title: "Alert", message: error as? String, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                 
                    DispatchQueue.main.async
                        {
                         
                            
                         //   self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
             
            }
         
        
        }

  
  
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

