//
//  ChooseDeleteViewController.swift
//  QuickPhoneCall
//
//  Created by 辛忠翰 on 2016/3/20.
//  Copyright © 2016年 Hsinhan. All rights reserved.
//

import UIKit

class ChooseDeleteViewController: UIViewController {
    
    @IBAction func backToRootView(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true )
    }
    
    @IBAction func deletEntryButton(sender: UIButton) {
        
        nameArray[selectedNumber] = ""
        phoneArray[selectedNumber] = ""
        NSUserDefaults.standardUserDefaults().setObject(nameArray, forKey: "contactName")
        NSUserDefaults.standardUserDefaults().setObject(phoneArray, forKey: "contactPhoneNum")
                settingName = nil
        settingPhoneNumber = nil
        self.navigationController?.popToRootViewControllerAnimated(true )
        
    }
    
    @IBAction func editEntryButton(sender: UIButton) {
        self.performSegueWithIdentifier("showEditName", sender: nil)
        
    }
    override func viewDidLoad() {//當按完button，畫面一跳到ChooseDeleteView後，馬上做viewDidLoad func的程式碼
        self.view.backgroundColor = colorArray[selectedNumber]//第一件事便是把背景顏色改為與button顏色相同
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}


