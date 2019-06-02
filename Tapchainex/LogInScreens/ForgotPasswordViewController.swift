//
//  ForgotPasswordViewController.swift
//  Tapchainex
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    
    
    func setUpUI(){
        sendBtn.backgroundColor = UIColor(red: 102/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1)
        sendBtn.applyGradientOrientation(withColours: [UIColor.init(red: 51, green: 51, blue: 255), UIColor.init(red: 102, green: 194, blue: 255)], gradientOrientation: .vertical)
        emailField.textColor = UIColor.gray
        emailField.setBottomLine(borderColor: UIColor.gray)
        emailField.attributedPlaceholder = NSAttributedString(string: "Your Email",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
