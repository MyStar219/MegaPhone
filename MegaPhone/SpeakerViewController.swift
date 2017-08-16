//
//  SpeakerViewController.swift
//  MegaPhone
//
//  Created by administrator on 8/3/17.
//  Copyright © 2017 administrator. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class SpeakerViewController: UIViewController {
    var radioButtonCheck: String = "Selected"
    var audioSession = AVAudioSession.sharedInstance() as AVAudioSession
    var volumeValue: Float = 0
    
    @IBOutlet weak var speaker_ImgView: UIImageView!
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var Mic_Lbl: UILabel!
    @IBOutlet weak var Speaker_Lbl: UILabel!
    @IBOutlet weak var Volume_Lbl: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (AVAudioSession.sharedInstance().outputVolume > 0.2) {
            Volume_Lbl.isHidden=true
        } else {
            Volume_Lbl.isHidden=false
        }
        if (Global.GlobalVariable.microPhoneCheck == "Bottom") {
            
            self.view.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            Mic_Lbl.text = "BOTTOM MIC"
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Front"){
            Mic_Lbl.text = "FRONT MIC"
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Back") {
            
            Mic_Lbl.text = "BACK MIC"
            
        }
        if (Global.GlobalVariable.isSpeakerConnectCheck == "SpeakerConnect") {
            if (Global.GlobalVariable.darkMode == "White") {
                speaker_ImgView.image = UIImage(named: "speaker.png")!
                
                if (radioButtonCheck == "Selected") {
                    radioButton.setImage(UIImage(named: "radio_selected.PNG"), for: .normal)
                } else {
                    radioButton.setImage(UIImage(named: "radio_unselected.PNG"), for: .normal)
                }
                settingButton.setImage(UIImage(named: "setting.PNG"), for: .normal)
                Mic_Lbl.textColor=UIColor.darkGray
                Speaker_Lbl.textColor=UIColor.darkGray
                Volume_Lbl.textColor=UIColor.darkGray
                
            } else if (Global.GlobalVariable.darkMode == "Dark"){
                speaker_ImgView.image = UIImage(named: "speaker_dark.PNG")!
                
                if (radioButtonCheck == "Selected") {
                    radioButton.setImage(UIImage(named: "radio_selected_dark.PNG"), for: .normal)
                } else {
                    radioButton.setImage(UIImage(named: "radio_unselected_dark.png"), for: .normal)
                }
                settingButton.setImage(UIImage(named: "setting_dark.png"), for: .normal)
                Mic_Lbl.textColor=UIColor.white
                Speaker_Lbl.textColor=UIColor.white
                Volume_Lbl.textColor=UIColor.white
            }
        } else {
            if (Global.GlobalVariable.SkipCheck == "No") {
                
                // Please insert the code of when connect the speaker
                let whenstart = DispatchTime.now() + 2 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: whenstart) {
                    
                    let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerConnectViewController") as! SpeakerConnectViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            } else if (Global.GlobalVariable.SkipCheck == "Yes") {
                if (Global.GlobalVariable.darkMode == "White") {
                    speaker_ImgView.image = UIImage(named: "speaker.png")!
                    
                    if (radioButtonCheck == "Selected") {
                        radioButton.setImage(UIImage(named: "radio_selected.PNG"), for: .normal)
                    } else {
                        radioButton.setImage(UIImage(named: "radio_unselected.PNG"), for: .normal)
                    }
                    settingButton.setImage(UIImage(named: "setting.PNG"), for: .normal)
                    Mic_Lbl.textColor=UIColor.darkGray
                    Speaker_Lbl.textColor=UIColor.darkGray
                    Volume_Lbl.textColor=UIColor.darkGray
                    
                } else if (Global.GlobalVariable.darkMode == "Dark"){
                    speaker_ImgView.image = UIImage(named: "speaker_dark.PNG")!
                    
                    if (radioButtonCheck == "Selected") {
                        radioButton.setImage(UIImage(named: "radio_selected_dark.PNG"), for: .normal)
                    } else {
                        radioButton.setImage(UIImage(named: "radio_unselected_dark.png"), for: .normal)
                    }
                    settingButton.setImage(UIImage(named: "setting_dark.png"), for: .normal)
                    Mic_Lbl.textColor=UIColor.white
                    Speaker_Lbl.textColor=UIColor.white
                    Volume_Lbl.textColor=UIColor.white
                }
            }
        }
//            (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(volumeValue, animated: false)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SpeakerViewController.audioRouteChangeListener(_:)),
            name: NSNotification.Name.AVAudioSessionRouteChange,
            object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()
    }
    
    func listenVolumeButton(){
        do{
            try audioSession.setActive(true)
            let vol = audioSession.outputVolume
            print(vol.description) //gets initial volume
        }
        catch{
            print("Error info: \(error)")
        }
        audioSession.addObserver(self, forKeyPath: "outputVolume", options:
            NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            let volume = (change?[NSKeyValueChangeKey.newKey] as!
                NSNumber).floatValue
            print("volume " + volume.description)
            volumeValue = volume
            
            if (volumeValue > 0.2) {
                Volume_Lbl.isHidden=true
            } else {
                Volume_Lbl.isHidden=false
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
    }
    
    
    @IBAction func RadioButtonClicked(_ sender: UIButton) {
        if (Global.GlobalVariable.darkMode == "White") {
            if (radioButtonCheck == "Selected") {
                radioButton.setImage(UIImage(named: "radio_selected.PNG"), for: .normal)
                radioButtonCheck = "UnSelected"
                SpeakerOutputEnabled()
            } else {
                radioButton.setImage(UIImage(named: "radio_unselected.PNG"), for: .normal)
                radioButtonCheck = "Selected"
                SpeakerOutputDisabled()
            }
        } else if (Global.GlobalVariable.darkMode == "Dark"){
            if (radioButtonCheck == "Selected") {
                radioButton.setImage(UIImage(named: "radio_selected_dark.PNG"), for: .normal)
                radioButtonCheck = "UnSelected"
                SpeakerOutputEnabled()
            } else {
                radioButton.setImage(UIImage(named: "radio_unselected_dark.png"), for: .normal)
                radioButtonCheck = "Selected"
                SpeakerOutputDisabled()
            }
        }
        
    }
    func SpeakerOutputEnabled() {
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeVoiceChat)
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        }
        catch{
            print("Error info: \(error)")
        }
    }
    func SpeakerOutputDisabled() {
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeVoiceChat)
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.none)
        }
        catch{
            print("Error info: \(error)")
        }
    }

    @IBAction func SettingButtonClicked(_ sender: UIButton) {
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerSettingViewController") as! SpeakerSettingViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            print("headphone plugged in")
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            if (Global.GlobalVariable.isSpeakerConnectCheck == "SpeakerConnect") {
                // Please insert the code of when connect the speaker
                Global.GlobalVariable.isSpeakerConnectCheck = "SpeakerDisConnect"
                DispatchQueue.main.async(execute: {
                    let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerConnectViewController") as! SpeakerConnectViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                });
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
