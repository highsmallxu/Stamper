//
//  ViewController.swift
//  client
//
//  Created by Linglin Zhang on 2019/1/10.
//  Copyright © 2019 stamper. All rights reserved.
//
import UIKit
import Foundation
import FirebaseAuthUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginTapped(_ sender: UIButton) {
        //Get the default auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            // Log the error
            return
        }
        //Set ourselves as the delegate
        authUI?.delegate = self
        //Get a reference to the auth UI viewController
        let authViewController = authUI!.authViewController()
        //Show it
        
        present(authViewController, animated: true, completion: nil)
    }
}


extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // Check if there was an error
//        guard error == nil else {
//            // Log the error
//            return
//        }
        
        if error != nil {
            // Log error
            return
        }
        
        //authDataResult?.user.uid
        
        performSegue(withIdentifier: "Gohome", sender: self)
    }
}
