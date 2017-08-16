//
//  WatchViewController.swift
//  MegaPhone
//
//  Created by administrator on 8/3/17.
//  Copyright © 2017 administrator. All rights reserved.
//

import UIKit

class WatchViewController: UIViewController {

    @IBOutlet weak var youtubeWebview: UIWebView!
    var displayYoutubeURL: String = "https://www.youtube.com/watch?v=WFGNGAlaVys"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubeWebview.loadRequest(URLRequest(url: URL(string: displayYoutubeURL)!))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func OptionsButtonClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func OptionsImageButtonClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
