//
//  SettingsTableViewController.swift
//  Tapchainex
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UIViewController{
  
    var switchThemeArray = ["sun","moon"]
    var settingsTitleLbl = ["Passcode Lock", "Signal Notification", "Language","","","","Read it"]
    var settingsSubTitleLbl = ["Disabled", "Enabled", "Disabled", "Rating & Review", "Share TapChainEx", "Send Feedback", "Terms of use & Privacy"]
    
    var themeCell = ThemeColorModeCollectionViewCell()
    var screen = UIScreen.main.bounds
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ThemeColorModeCollectionViewCell.nib, forCellWithReuseIdentifier: ThemeColorModeCollectionViewCell.identifier)
        tableView.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
       // tableView.separatorColor = UIColor.gray
        tableView.rowHeight = 60
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    

    
   

}

//setting up Collection and Table View



extension SettingsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSubTitleLbl.count
    }
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 2
    //    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let themeCell = tableView.dequeueReusableCell(withIdentifier: "SwitchThemeCell", for: indexPath) as? UITableViewCell
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell
        let chevron = UIImage(named: "chevron")
        chevron?.draw(in: CGRect(x: 125, y: 0, width: 20, height: 20))
        settingsCell!.accessoryType = .disclosureIndicator
        settingsCell!.accessoryView = UIImageView(image: chevron)
        settingsCell?.titleLbl?.text = settingsTitleLbl[indexPath.item]
        settingsCell?.subtitleLbl?.text = settingsSubTitleLbl[indexPath.item]
        return settingsCell!
    }
    
    func tableView(_ collectionView: UITableView, didSelectItemAt indexPath: IndexPath) {
         if indexPath.row != 0 {
        performSegue(withIdentifier: "toDetailSettings", sender: self)
        }
         else{
            return
        }
    }
    
}

extension SettingsTableViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeColorModeCollectionViewCell", for: indexPath) as? ThemeColorModeCollectionViewCell
        cell?.imageTheme.image = UIImage(named: switchThemeArray[indexPath.row])
        if cell?.imageTheme.image == UIImage(named: "sun") {
            cell?.themeName.textColor = UIColor.black
            cell?.themeName.text = "White Theme"
            cell?.bgView.backgroundColor = UIColor.init(red: 248, green: 248, blue: 248)
        }
//         if cell?.imageTheme.image == UIImage(named: "moon"){
//            cell?.themeName.textColor = UIColor.white
//        }
        return cell!
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 350, height: 120)
//    }
    
    
}


