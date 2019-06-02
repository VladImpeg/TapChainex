//
//  ThemeColorModeCollectionViewCell.swift
//  Tapchainex
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class ThemeColorModeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageTheme: UIImageView!
    @IBOutlet weak var themeName: UILabel!
   //@IBOutlet weak var selectThemeLbl: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageTheme.addGestureRecognizer(pictureTap)
            imageTheme.isUserInteractionEnabled = true
        
        
        bgView.layer.backgroundColor = UIColor.init(red: 0, green: 4, blue: 33).cgColor
      bgView.layer.cornerRadius = 15
        bgView.dropShadow()
        // Initialization code
    }
    

    @objc func imageTapped() {
        if imageTheme.image == UIImage.init(named: "sun"){
            //            UIColor.initWithColorScheme(cs: .Custom)
            //            for subview in self.view.subviews{
            //                subview.setNeedsDisplay()
            //            }
          
            
        }
        else if imageTheme.image == UIImage.init(named: "moon"){
           
         
            
        }
    }
    
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
