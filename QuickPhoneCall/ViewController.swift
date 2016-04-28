//
//  ViewController.swift
//  QuickPhoneCall
//
//  Created by 辛忠翰 on 2016/3/19.
//  Copyright © 2016年 Hsinhan. All rights reserved.
//

import UIKit
var colorArray:[UIColor]!//為了讓轉場後的view可以根據button的color當backGround Color，所以將colorArray提到class外，可以讓所有的class都知道著個變數

var selectedNumber:Int = -1//看之後選到哪個button，可以讓這個變數記錄下來(主要用在lonPress func 中，紀錄sender.view!.tag - 100這個判別哪個button的值)

var nameArray:[String] = ["", "", "", "", ""]//此Array用來儲存所有人的名字
var phoneArray:[String] = ["", "", "", "", ""]//此Array用來儲存所有人的phoneNumber
var isSetting:Bool = false//此變數用來定義是否此時有人正在設定新的資料，一開始沒有所以是false
var settingName:String?//此變數用來記錄儲存過程中，打算存進手機的聯絡人名字
var settingPhoneNumber:String?//此變數用來記錄儲存過程中，打算存進手機的聯絡人電話


class ViewController: UIViewController {
    //當程式碼生成button時便會觸發BigLabelButton class init func中定義的程式碼
    
    @IBOutlet weak var button1: BigLabelButton!
    
    @IBOutlet weak var button2: BigLabelButton!
    
    @IBOutlet weak var button3: BigLabelButton!
    
    @IBOutlet weak var button4: BigLabelButton!
    
    @IBOutlet weak var button5: BigLabelButton!
    
    @IBAction func buttonTouched(sender: BigLabelButton) {//touch down表再按下button的時候便會同時執行程式碼
        let buttonNum = sender.tag - 100//得到目前觸發button的tag號碼在剪掉100，這是為了能讓button變成按下去後的顏色
        buttonArray[buttonNum].backgroundColor = colorPressArray[buttonNum]//拿到被按下去的button，並把button的背景顏色改成按下後應該要出現的顏色
        buttonArray[buttonNum].bigLabel.textColor = colorPressArray[5]//並把按下的button上的label文字改為灰色

    }
    
    @IBAction func pressEnded(sender: BigLabelButton) {//touch inside表按完button後，若手指還在螢幕button範圍內則執行此段程式碼
        let buttonNum = sender.tag - 100
        buttonArray[buttonNum].backgroundColor = colorArray[buttonNum]//拿到被按下去的button，但按完button的背景顏色應改為還未按下去的顏色
        buttonArray[buttonNum].bigLabel.textColor = colorArray[5]//並把按下的button上的label文字改為還未按下去的顏色
        
        //以下程式碼是打電話的程式碼
        let thisName:String? = nameArray[selectedNumber]//抓取按下butoon的名字
        let thisPhoneNum:String? = phoneArray[selectedNumber]//抓取按下butoon的電話
        
        if thisName != nil{//按下按鈕後便會看看按下的按鈕是否有儲存聯絡人的名字．若有存的話
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "tel://\(thisPhoneNum!)")!) == true {//若有存電話的話，看看這個儲存的電話是否能夠打開這個url(canOpenURL代表此電話號碼能否撥電話的意思)，若為true代表可以撥電話
            let url = NSURL(string: "tel://\(thisPhoneNum)")//便用此電話號碼做成一個url
            UIApplication.sharedApplication().openURL(url!)//再用這行程式碼去打電話
        }
        }

    }
    
    @IBAction func outsideEnded(sender: BigLabelButton)  {//touch inside表按完button後，若手指不是在螢幕上剛剛按的button範圍內放開(按錯的情況)則執行此段程式碼，換言之極為使用者按錯按鈕的情況
        let buttonNum = sender.tag - 100//得到目前觸發button的tag號碼在剪掉100，這是為了能讓button變成按下去後的顏色
        buttonArray[buttonNum].backgroundColor = colorArray[buttonNum]//拿到被按下去的button，但按完button的背景顏色應改為還未按下去的顏色
        buttonArray[buttonNum].bigLabel.textColor = colorArray[5]//並把按下的button上的label文字改為還未按下去的顏色


    }
    var buttonArray:[BigLabelButton]!//會儲存所有的button
    var viewWidth:CGFloat!//會儲存等下程式執行時畫面的寬度
    var viewHeight:CGFloat!//會儲存等下程式執行時畫面的高度
    //var colorArray:[UIColor]!//還未按下按鈕時，各個按鈕的原色
    var colorPressArray:[UIColor]!//按下按鈕後，各個按鈕的變色
    
  
    
    override func viewWillAppear(animated: Bool) {//這個func是重新把button和label顏色設為還未按下去的顏色。But為何我們不把這兩行程式碼加在viewDidLoad裡面呢？因為我們這個app會一直需要轉場，但我們希望每次轉回這個rootView時都能把顏色重置。所以我們需把顏色重置這段程式碼寫在viewWillAppear func中，這代表每回到這個view便執行一次這段func中的程式
        isSetting = false
        settingName = nil
        settingPhoneNumber = nil
        //重新轉回這個root畫面，便把這3個值設為預設值
        for var i = 0 ; i < buttonArray.count ; i++ {
            buttonArray[i].backgroundColor = colorArray[i]
            buttonArray[i].bigLabel.textColor = colorArray[5]
        }
        for var i=0 ; i<nameArray.count ; i++ {
            if nameArray[i] != ""{
                buttonArray[i].bigLabel.text = nameArray[i]
            }else{
                buttonArray[i].bigLabel.text = "Long Press!!"
            }
        }
        //重新轉回這個root畫面，都要做以下程式碼，為了讓輸入的聯絡人會出現在root view上的button  選項
        /*var isEmpty:Bool = true//用來判斷nameArray及numberArray有沒有存聯絡人的資料
        
        for var i=0 ; i<5 ; i++ {//若nameArray不為空值，表有聯絡人資訊，所以將isEmpty改為false
            if nameArray[i] != ""{
                isEmpty = false
            }
        }
        if isEmpty == true {//若都無聯絡人資訊，則把button上的lable改為空字串，並把隱藏起button所有的文字。接著把第一個button的文字改為long Press提醒使用者長按已儲存聯絡人資訊
            for var i=0 ; i<5 ;i++ {
                buttonArray[i].bigLabel.text = ""
                buttonArray[i].bigLabel.hidden = true
            }
            buttonArray[0].bigLabel.text = "Long Press"
            buttonArray[0].bigLabel.hidden = false
        }else {//若有了聯絡人資訊
            for var i=0 ; i<5 ; i++ {
                if nameArray[i] != ""{
                buttonArray[i].bigLabel.text = nameArray[i]//則把nameArray的聯絡人名字存入button上的label
                buttonArray[i].bigLabel.hidden = false
                }else{
                buttonArray[i].bigLabel.hidden = true
                }
            }
        }*/
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWidth = view.frame.size.width//程式執行時畫面的寬度
        viewHeight = view.frame.size.height//程式執行時畫面的高度
        buttonArray = [button1, button2, button3, button4, button5]
        for var i=0 ; i < buttonArray.count ; i++ {
            buttonArray[i].bigLabel.frame = CGRectMake(28, 0, viewWidth - 38, viewHeight/5)//把每個button取出，將button上的bigLabel做以下事情,其中frame表button文字的範圍,調整文字範圍的x座標為28,y座標為0,寬度為整個畫面寬度-38,高度為此畫面高度/5
            buttonArray[i].bigLabel.font = UIFont(name: "Arial-BoldMT", size: 45*(viewHeight/600)) //把在button上label的文字調整成Arial粗體，且文字大小為45*(viewHeight/600)
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: ("longPress:"))//直接由程式碼生成longPressRecognizer，長按button的話會執行longPress這個func，其中有：代表會執行呼叫有參數的longPress func(若是沒有：的話便會找沒有參數的longPress func, but我們沒有寫無參數的longPress func，所以程式就會出錯)
            longPressGestureRecognizer.minimumPressDuration = 1.5//設定要引發longPress事件所需的按的最短時間
            buttonArray[i].addGestureRecognizer(longPressGestureRecognizer)//將longPressGestureRecognizer加到button上

        }
        
        colorArray = [UIColor(red: 232/255, green: 68/255, blue: 32/255, alpha: 1),
                      UIColor(red: 250/255, green: 168/255, blue: 8/255, alpha: 1),
        			  UIColor(red: 2/255, green: 160/255, blue: 131/255, alpha: 1),
                      UIColor(red: 9/255, green: 171/255, blue: 219/255, alpha: 1),
                      UIColor(red: 3/255, green: 127/255, blue: 208/255, alpha: 1),
        UIColor.whiteColor()//還未按下按鈕時的文字為白色
        ]
        
        colorPressArray = [UIColor(red: 202/255, green: 38/255, blue: 1/255, alpha: 1),
            UIColor(red: 220/255, green: 138/255, blue: 0/255, alpha: 1),
            UIColor(red: 0/255, green: 130/255, blue: 101/255, alpha: 1),
            UIColor(red: 0/255, green: 141/255, blue: 189/255, alpha: 1),
            UIColor(red: 0/255, green: 97/255, blue: 178/255, alpha: 1),
            UIColor.grayColor()//還未按下按鈕時的文字為白色
        ]
        //檢查目前手機memory是否有存值
        if NSUserDefaults.standardUserDefaults().objectForKey("contactName") != nil {
            nameArray.removeAll(keepCapacity: true )//若有存值在手機的話，把原本存在nameArray的空字串殺掉，並把現在存在NSUserDeafaluts objectKey為contactName的字串存進去
            nameArray = NSUserDefaults.standardUserDefaults().objectForKey("contactName") as! Array//轉型成array，加上！確保轉型一定會成功，並存回至nameArray
            
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("contactPhone") != nil{
            phoneArray.removeAll(keepCapacity: true )
            phoneArray = NSUserDefaults.standardUserDefaults().objectForKey("contactPhone") as! Array
        }
    }
    
    func longPress(sender: UILongPressGestureRecognizer){//所以只要長按，便會觸發這個func，並把自己longPressGestureRecognizer當作參數傳進來。
        if sender.state == .Began{//知道剛開始要偵測長按時，便執行這段程式碼
            selectedNumber = sender.view!.tag - 100//sender.view!可抓到觸發長按事件的button(.tag為拿到button的tag)
            if nameArray[selectedNumber] != "" {
                self.performSegueWithIdentifier("showChooseDelete", sender: nil)
            }else{self.performSegueWithIdentifier("showSettingName", sender: nil)}
        }//else if sender.state == .Ended{}可設定按完按鈕後要執行的程式
    }
    

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }//把狀態列隱藏起來


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class BigLabelButton:UIButton{//因為我們想要讓按鈕有字體變大，距旁邊寬度等功能，現有的Button class無法提供，所以要自己新建一個button類別
      let bigLabel = UILabel()//用程式碼新增一個label
    
    //作為UIButton的子類別，都須定義init這個func
    required init?(coder aDecoder: NSCoder){//此init方法是storyBooard生成按鈕時要執行的func
        super.init(coder: aDecoder)//先執行父類別(UIButton)生成按鈕時要執行的init func
        bigLabel.text = "Long Press!!"//bigLabel要顯示Long Press!!字樣
        bigLabel.textColor = UIColor.whiteColor()//bigLabel的文字為白色
        bigLabel.shadowColor = UIColor.blackColor()//bigLabel的文字顯示陰影的顏色為黑色
        self.addSubview(bigLabel)//設定完成後，把bigLabel加到按鈕的view上
        //此時還不會更改butoon上的文字，所以要回到storyBoard更改按鈕的class從UIButton改為BigLabelButton的class
        
    }
    
}

