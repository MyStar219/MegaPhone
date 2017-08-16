//
//  SpeakerConnectViewController.swift
//  MegaPhone
//
//  Created by administrator on 8/3/17.
//  Copyright © 2017 administrator. All rights reserved.
//

import UIKit
import AVFoundation

class SpeakerConnectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if (Global.GlobalVariable.microPhoneCheck == "Bottom") {
            
            self.view.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Front"){
            
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Back") {
            
        }

        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    if (Global.GlobalVariable.isSpeakerConnectCheck == "SpeakerConnect") {
                        
                    } else {
                        Global.GlobalVariable.isSpeakerConnectCheck = "SpeakerConnect"
                        DispatchQueue.main.async(execute: {
                            let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerViewController") as! SpeakerViewController
                            self.navigationController?.pushViewController(viewController, animated: true)
                        });
                    }
                    print("headphone plugged in")
                } else {
                    if (Global.GlobalVariable.isSpeakerConnectCheck == "SpeakerDisConnect") {
                        
                    } else {
                        Global.GlobalVariable.isSpeakerConnectCheck = "SpeakerDisConnect"
                    }
                    print("headphone pulled out")
                }
            }
        } else {
            print("requires connection to device")
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SpeakerConnectViewController.audioRouteChangeListener(_:)),
            name: NSNotification.Name.AVAudioSessionRouteChange,
            object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SettingButtonClicked(_ sender: UIButton) {
        Global.GlobalVariable.SkipCheck="Yes"
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerViewController") as! SpeakerViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
    dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            if (Global.GlobalVariable.isSpeakerConnectCheck == "SpeakerConnect") {
                
            } else {
                Global.GlobalVariable.isSpeakerConnectCheck = "SpeakerConnect"
                DispatchQueue.main.async(execute: {
                    let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerViewController") as! SpeakerViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                });
                
            }
            print("headphone plugged in")
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            if (Global.GlobalVariable.isSpeakerConnectCheck == "SpeakerDisConnect") {
                
            } else {
                Global.GlobalVariable.isSpeakerConnectCheck = "SpeakerDisConnect"
            }
            print("headphone pulled out")
        default:
            break
        }
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
