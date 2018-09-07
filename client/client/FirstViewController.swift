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

        
        
        
        var uuid = UUID().uuidString;
        var ref:DatabaseReference!
        ref = Database.database().reference()
        ref.child("merchant")
            .child("merchant1")
            .setValue(["stampId":uuid]){
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print(error)
                    print("Data could not be saved")
                } else {
                    print("Data saved sucessfully")
                }
        }
        
        
        
        
        
//        ref.child("merchant").setValue(["merchant1":uuid])
        print(uuid)
    }
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
    }
    
    
    
    


}

