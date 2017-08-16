//
//  MicSettingViewController.swift
//  MegaPhone
//
//  Created by administrator on 8/3/17.
//  Copyright © 2017 administrator. All rights reserved.
//

import UIKit


class MicSettingViewController: UIViewController {
    @IBOutlet weak var micBottom_Img: UIImageView!
    @IBOutlet weak var micFront_Img: UIImageView!
    @IBOutlet weak var micBack_Img: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Global.GlobalVariable.microPhoneCheck == "Bottom") {
            micBottom_Img.isHidden = false
            micFront_Img.isHidden = true
            micBack_Img.isHidden = true
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Front"){
            micFront_Img.isHidden = false
            micBack_Img.isHidden = true
            micBottom_Img.isHidden = true
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Back") {
            micBack_Img.isHidden = false
            micBottom_Img.isHidden = true
            micFront_Img.isHidden = true
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MicBottomButtonClicked(_ sender: UIButton) {
        micBottom_Img.isHidden = false
        micFront_Img.isHidden = true
        micBack_Img.isHidden = true
        Global.GlobalVariable.microPhoneCheck = "Bottom"
    }

    @IBAction func MicFrontButtonClicked(_ sender: UIButton) {
        micFront_Img.isHidden = false
        micBack_Img.isHidden = true
        micBottom_Img.isHidden = true
        Global.GlobalVariable.microPhoneCheck = "Front"
        
    }

    @IBAction func MicBackButtonClicked(_ sender: UIButton) {
        micBack_Img.isHidden = false
        micBottom_Img.isHidden = true
        micFront_Img.isHidden = true
        Global.GlobalVariable.microPhoneCheck = "Back"
        
    }
    
    @IBAction func OptionsButtonClicked(_ sender: UIButton) {

        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerSettingViewController") as! SpeakerSettingViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func OptionsImageButtonClicked(_ sender: UIButton) {
        
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerSettingViewController") as! SpeakerSettingViewController
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
