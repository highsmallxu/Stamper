//
//  FirstViewController.swift
//  client
//
//  Created by GAOXiaoXu on 2018-07-13.
//  Copyright © 2018 stamper. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var qrcodeImage: CIImage!


    @IBAction func button(_ sender: UIButton) {
        
        if(qrcodeImage==nil){
            
            let data = textField.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            
            textField.resignFirstResponder()
            
            displayQRCodeImage()
            
            
        }

        
        
        
//        var uuidMerchant = UUID().uuidString;
//        var uuidClient = UUID().uuidString;
//        var ref:DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("merchant")
//            .child("merchant1")
//            .setValue(["stampId":uuid]){
//                (error:Error?, ref:DatabaseReference) in
//                if let error = error {
//                    print(error)
//                    print("Data could not be saved")
//                } else {
//                    print("Data saved sucessfully")
//                }
//        }
        
        //用户扫商家-获得一枚stamp
        var uuidMerchant = UUID().uuidString; //从二维码中获取
        uuidMerchant = "merchantID_1"; //暂时假设为merchantID_1
        var uuidClient = UUID().uuidString; //从用户信息中获取
        uuidClient = "clientID_1"; //暂时假设为clientID_1
        var timestamp = NSDate().timeIntervalSince1970;
        var ref:DatabaseReference!
        ref = Database.database().reference()
        ref.child("client")
            .child(uuidClient)
            .child("merchantCards")
            .child(uuidMerchant)
            .child("stamp")
            .setValue(["stampID":uuidMerchant+uuidClient+String(timestamp)]){
                (error:Error?,ref:DatabaseReference) in
                if let error = error {
                    print(error)
                    print("Data could not be saved")
                } else{
                    print("Data saved successfully in client")
                }
        }
        
        //商家记录给出一枚stamp
        ref.child("merchant")
            .child("stamp")
            .setValue(["stampID":uuidMerchant+uuidClient+String(timestamp)]){
                (error:Error?,ref:DatabaseReference) in
                if let error = error {
                    print(error)
                    print("Data could not be saved")
                } else{
                    print("Data saved successfully into merchant")
                }
        }
        
        //商家给出新卡
        ref.child("client")
            .child(uuidClient)
            .child("merchantCards")
            .child(uuidMerchant)
            .child("creationTime")
            .setValue(["timestamp":String(timestamp)]){
                (error:Error?,ref:DatabaseReference) in
                if let error = error {
                    print(error)
                    print("Data could not be saved")
                } else{
                    print("Data saved successfully in client")
                }
        }

        
        
        
//        ref.child("merchant").setValue(["merchant1":uuid])
    }
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
    }
    
    
    
    


}

