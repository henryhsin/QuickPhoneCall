//
//  SettingNameViewController.swift
//  QuickPhoneCall
//
//  Created by 辛忠翰 on 2016/3/20.
//  Copyright © 2016年 Hsinhan. All rights reserved.
//

import UIKit 

class SettingNameViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func backToMAinButton(sender: UIButton) {
        settingName = nil
        settingPhoneNumber = nil //返回之前要先確保name和number為nil
        self.navigationController?.popToRootViewControllerAnimated(true )//按下backToMain button後，回到root View(viewController)
        //其中EnterNameViewController,EnterPhoneViewController,SettingViewController,viewController都是navigationViewController的children
    }
    override func viewDidLoad() {//當按完button，畫面一跳到SettingNameView後，馬上做viewDidLoad func的程式碼
        self.view.backgroundColor = colorArray[selectedNumber]//第一件事便是把背景顏色改為與button顏色相同
        nameTextField.autocorrectionType = UITextAutocorrectionType.No//取消程式自動改正輸入文字的功能
        nameTextField.returnKeyType = UIReturnKeyType.Next//把keyboard上return鍵上的enter改為next
        nameTextField.becomeFirstResponder()//讓鍵盤主動跳出來
        //若是要修改聯絡人資訊，可以預先出現在textField上
        if nameArray[selectedNumber] != "" {
            nameTextField.text = nameArray[selectedNumber]
        }
        //接下來的問題是如何偵測user已經按下   next了，先回到mainStoryBoard，把textField的delegate連到EnterNameViewController，表示接下來textField遇到什麼問題可以去問viewController。最後再到class上加入UITextFieldDelegate
        isSetting = true//表剛開始設定
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {//表示若user按下keyBoard的return鍵後，會執行這個finc的程式碼
      if nameTextField.text == ""{//若user無輸入文字，跳出警告視窗
        
           let nameAlert =  UIAlertController(title: "OOPS" , message: "Please enter the contact name!!", preferredStyle: .Alert)
           let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil )
           nameAlert.addAction(okButton)
           self.presentViewController(nameAlert, animated: true, completion: nil)
        }
        else{//若user有輸入文字
                settingName = nameTextField.text//將輸入的文字存入settingName
            self.performSegueWithIdentifier("showSettingNumber", sender: nil)//在轉場到輸入phoneNumber的view

        }
        /*self.performSegueWithIdentifier("showSettingNumber", sender: nil)//若使用者按下keyBoard的enter(next)後，會轉場到settingNumberViewController(Enter Phone View)*/
        return true
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
