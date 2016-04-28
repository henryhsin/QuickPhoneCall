//
//  SettingNumberViewController.swift
//  QuickPhoneCall
//
//  Created by 辛忠翰 on 2016/3/20.
//  Copyright © 2016年 Hsinhan. All rights reserved.
//

import UIKit

class SettingNumberViewController: UIViewController ,UITextFieldDelegate{
   
   
    @IBOutlet weak var phoneTextField: UITextField!
    @IBAction func backToSeeingNameButton(sender: UIButton) {
        //其中EnterNameViewController,EnterPhoneViewController,SettingViewController,viewController都是navigationViewController的children
        let vc = navigationController?.childViewControllers[1]
        //其中EnterPhoneViewController為NavigationViewController.childViewControllers[1]
        self.navigationController?.popToViewController(vc!, animated: true)//按下button後，跳到vc!=childViewControllers[1]的畫面，加上！是確保一定有這個view
    }
    override func viewDidLoad() {//當按完button，畫面一跳到SettingNumberView後，馬上做viewDidLoad func的程式碼
        self.view.backgroundColor = colorArray[selectedNumber]//第一件事便是把背景顏色改為與button顏色相同
        phoneTextField.becomeFirstResponder()//一進入畫面，phoneTextField便會讓keyBoard主動跳出來
        phoneTextField.returnKeyType = UIReturnKeyType.Done//在keyBoard上的enter鍵，變為done
        if phoneArray[selectedNumber] != "" {
            phoneTextField.text = phoneArray[selectedNumber]
        }

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if phoneTextField.text == ""{
            let phoneAlert = UIAlertController(title: "OOPS" , message: "Please enter contact's phone number!!", preferredStyle: .Alert )
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil )
            phoneAlert.addAction(okButton)
            self.presentViewController(phoneAlert, animated: true, completion: nil )
        }else{
            settingPhoneNumber = phoneTextField.text!
           /* let phoneAlert = UIAlertController(title: "Successful!!" , message: "You enter the phoneNumber \(settingPhoneNumber!)", preferredStyle: .Alert )
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil )
            phoneAlert.addAction(okButton)
            self.presentViewController(phoneAlert, animated: true, completion: nil )
            */
            nameArray[selectedNumber] = settingName!
            phoneArray[selectedNumber] = settingPhoneNumber!
            NSUserDefaults.standardUserDefaults().setObject(nameArray, forKey:  "contactName")
            NSUserDefaults.standardUserDefaults().setObject(phoneArray, forKey: "contactPhone")
            isSetting = false //再回去root view前因為設定完成,所以把所有值改為初始值
            settingName = nil
            settingPhoneNumber = nil
             self.navigationController?.popToRootViewControllerAnimated(true )//按下done後(設定完phone number後便返回至主畫面"rootViewController")
            }
        
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
