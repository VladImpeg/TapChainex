//
//  HomeViewController.swift
//  Tapchainex
//
//  Created by admin on 11/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var welcomeLbl: UILabel!
    
    @IBOutlet weak var meBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadMemberProfile()
//        self.meBtn?.backgroundColor = UIColor(red: 102/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1)
//        self.meBtn?.applyGradientOrientation(withColours:  [UIColor.white, UIColor.blue], gradientOrientation: .horizontal)

        //meBtn.applyGradient(colours: [UIColor.yellow, UIColor.blue, UIColor.red], locations: [0.0, 0.5, 1.0])
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func signOutButtonTapped(_ sender: Any) {
//        KeychainWrapper.standard.removeObject(forKey: "Token")
//        //KeychainWrapper.standard.removeObject(forKey: "userId")
//
//        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        let appDelegate = UIApplication.shared.delegate
//        appDelegate?.window??.rootViewController = signInPage
//
//    }
    
//    @IBAction func loadMemberProfileButtonTapped(_ sender: Any) {
//        loadMemberProfile()
//    }
   
    
    
    @IBAction func getInfo(_ sender: Any) {
          let accessToken: String? = KeychainWrapper.standard.string(forKey: "Token")
        let headers = ["Authorization": "Bearer \(accessToken!)"]
        Alamofire.request("https://tce-api-v2.azurewebsites.net/api/Pool/GetAllAlgorithms", headers: headers).responseJSON { (response) in
            print(response)
            
        }
        
        
    }
    func loadMemberProfile()
    {
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "Token")
        let accessId: Int = KeychainWrapper.standard.integer(forKey: "Id")!
        //Send HTTP Request to perform Sign in
        let myUrl = URL(string: "https://tce-api-v2.azurewebsites.net/api/Users/\(accessId)")
        let headers = ["Authorization": "Bearer \(accessToken!)"]
        Alamofire.request(myUrl!, headers: headers).responseJSON { (response) in
            
            
            
        
        
        
    
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    DispatchQueue.main.async
                        {
                            let firstName: String?  = parseJSON["Username"] as? String
                            
                            
                            if firstName?.isEmpty != true {
                                self.welcomeLbl.text =  firstName!
                            }
                    }
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
            
        }
    
        
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
}
