//
//  Global.swift
//  MegaPhone
//
//  Created by Jin Huang on 8/7/17.
//  Copyright © 2017 administrator. All rights reserved.
//

import UIKit

class Global: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct GlobalVariable {
        static var isSpeakerConnectCheck = ""
        static var microPhoneCheck = "Front"
        static var darkMode = "White"
        static var SkipCheck = "No"
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
