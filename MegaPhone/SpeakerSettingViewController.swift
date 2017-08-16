//
//  SpeakerSettingViewController.swift
//  MegaPhone
//
//  Created by administrator on 8/3/17.
//  Copyright © 2017 administrator. All rights reserved.
//

import UIKit
import AVFoundation
import CoreBluetooth

class SpeakerSettingViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralManagerDelegate {

    @IBOutlet weak var micType_Lbl: UILabel!
    @IBOutlet weak var gainSlider: UISlider!
    @IBOutlet weak var bluetoothSwitch: UISwitch!
    @IBOutlet weak var modeSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    @IBOutlet weak var deviceCheckView: UIView!
    @IBOutlet weak var deviceCheckCancel: UIView!
    @IBOutlet weak var deviceType_Img: UIImageView!
    @IBOutlet weak var deviceType_Lbl: UILabel!
    @IBOutlet weak var deviceCheckAllowView: UIImageView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.deviceCheckView.isHidden = true
        self.deviceCheckCancel.isHidden = true
        bluetoothSwitch.setOn(false, animated: false)
        modeSwitch.setOn(false, animated: false)
        soundSwitch.setOn(false, animated: false)
        if (Global.GlobalVariable.microPhoneCheck == "Bottom") {
            micType_Lbl.text = "iPhone Microphone - Bottom"
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Front"){
            micType_Lbl.text = "iPhone Microphone - Front"
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Back") {
            micType_Lbl.text = "iPhone Microphone - Back"
            
        }
        gainSlider.value = 0.375
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
        
    }
    
    private func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print(peripheral)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print(peripheral)

        if (peripheral.state == .poweredOn) {
            let alert = UIAlertController(title: "No Bluetooth Speaker Selected", message: "Ensure that your is paired in Setting, and is selected. Once it is paired, you can select it from the list available by touching the AirPlay icon at the top of the screen", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if (peripheral.state == .poweredOff){
            let alert = UIAlertController(title: "No Bluetooth Speaker Selected", message: "Ensure that your is paired in Setting, and is selected. Once it is paired, you can select it from the list available by touching the AirPlay icon at the top of the screen", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func DeviceCheckButtonClicked(_ sender: UIButton) {
        self.deviceCheckView.isHidden = false
        self.deviceCheckCancel.isHidden = false
        self.deviceCheckView.layer.cornerRadius = 10
        self.deviceCheckCancel.layer.cornerRadius = 10
        
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            
            self.deviceType_Img.isHidden = false
            self.deviceCheckAllowView.isHidden = false
            self.deviceType_Img.frame.size.width = 20
            self.deviceType_Img.image = UIImage(named: "iphone.PNG")
            self.deviceType_Lbl.text = "iPhone"
            
        } else if (UIDevice.current.userInterfaceIdiom == .pad) {
            
            self.deviceType_Img.isHidden = false
            self.deviceCheckAllowView.isHidden = false
            self.deviceType_Img.frame.size.width = 40
            self.deviceType_Img.image = UIImage(named: "ipad.PNG")
            self.deviceType_Lbl.text = "iPad"
            
        } else if (UIDevice.current.userInterfaceIdiom == .unspecified) {
            
            self.deviceType_Img.isHidden = true
            self.deviceCheckAllowView.isHidden = true
            self.deviceType_Lbl.text="Unspecified"
        
        }
    
    }
    
    @IBAction func GainSliderChanged(_ sender: UISlider) {
        
        do {
            try AVAudioSession.sharedInstance().setInputGain(sender.value*5)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    @IBAction func BluetoothSwitchChanged(_ sender: UISwitch) {
        
        if (sender.isOn == true){
            let currentRoute = AVAudioSession.sharedInstance().currentRoute
            for route in currentRoute.outputs {
                print("PortType \(route.portType), Description \(route.portName)")
                if route.portType == "BluetoothA2DPOutput"{
                    print("Bluetooth detected")
                    let portDescription = route
                    do{
                        try AVAudioSession.sharedInstance().setPreferredInput(portDescription)
                    }
                    catch{
                        print("Error info: \(error)")
                    }
                    
                } else {
                    print("No Bluetooth, speaker only")
                    let alert = UIAlertController(title: "No Bluetooth Speaker Selected", message: "Ensure that your is paired in Setting, and is selected. Once it is paired, you can select it from the list available by touching the AirPlay icon at the top of the screen", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    do{
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                    }
                    catch{
                        print("Error info: \(error)")
                    }
                }
            }
            print("Bluetooth UISwitch state is now ON")
            do{
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.allowBluetooth)
            } catch{
                print(error)
            }
            
            let manager = CBCentralManager.init(delegate: self, queue: nil)
            manager.scanForPeripherals(withServices: nil, options: nil)
        }
        else{
            print("Bluetooth UISwitch state is now Off")
        }
    }
    
    @IBAction func ModeSwitchChanged(_ sender: UISwitch) {
        
        if (sender.isOn == true){
            print("Mode UISwitch state is now ON")
            Global.GlobalVariable.darkMode = "Dark"
        }
        else{
            print("Mode UISwitch state is now Off")
            Global.GlobalVariable.darkMode = "White"
        }
    }
    
    
    @IBAction func SoundSwitchChanged(_ sender: UISwitch) {
        
        if (sender.isOn == true){
            print("Sound UISwitch state is now ON")
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                print("AVAudioSession Category Playback OK")
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                    print("AVAudioSession is Active")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        else{
            print("Sound UISwitch state is now Off")
        }
    }
    
    @IBAction func MicTypeButtonClicked(_ sender: UIButton) {
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "MicSettingViewController") as! MicSettingViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func SpeakersButtonClicked(_ sender: UIButton) {
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerDetailViewController") as! SpeakerDetailViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func InstructionButtonClicked(_ sender: UIButton) {
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "InstructionViewController") as! InstructionViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func WatchButtonClicked(_ sender: UIButton) {
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "WatchViewController") as! WatchViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func DoneButtonClicked(_ sender: UIButton) {
        
        if (Global.GlobalVariable.microPhoneCheck == "Bottom") {
            self.view.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
        } else if (Global.GlobalVariable.microPhoneCheck == "Front"){
            
        } else if (Global.GlobalVariable.microPhoneCheck == "Back") {
            
        }
        
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "SpeakerViewController") as! SpeakerViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func DeviceCheckCancelButtonClicked(_ sender: UIButton) {
        
        self.deviceCheckView.isHidden = true
        self.deviceCheckCancel.isHidden = true
        
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

enum UIUserInterfaceIdiom : Int {
    case unspecified

    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}
