//
//  InstafeedViewController.swift
//  Instagram
//
//  Created by Shakeel Daswani on 3/14/16.
//  Copyright © 2016 shakeeld. All rights reserved.
//

import UIKit
import Parse

class InstafeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




@IBAction func onLogoutButton(sender: AnyObject) {
    PFUser.logOut()
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
