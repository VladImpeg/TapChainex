//
//  ViewController.swift
//  Tapchainex
//
//  Created by admin on 11/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var WalletBtn: UIButton!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        initSignUpBtn()
   
    }
 
    
    func setButtons() {
     
   
      
       // logInBtn.clipsToBounds = true
      
        LoginBtn.layer.cornerRadius = 30
        LoginBtn.layer.borderWidth = 1
        LoginBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 1, alpha: 1)
        WalletBtn.layer.cornerRadius = 30
        WalletBtn.layer.borderWidth = 1
        WalletBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 1, alpha: 1)
    }

    
    func initSignUpBtn() {
      
     SignUpBtn.backgroundColor = UIColor(red: 102/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1)
        SignUpBtn.applyGradientOrientation(withColours: [UIColor.init(red: 51, green: 51, blue: 255), UIColor.init(red: 102, green: 194, blue: 255)], gradientOrientation: .vertical)
        
    }
  
    
    
}

