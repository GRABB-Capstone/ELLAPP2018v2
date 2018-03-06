//
//  ManageProfileViewController.swift
//  ELLAPP2017
//
//  Created by Nick Ponce on 1/25/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import UIKit
import Parse

class ManageProfileViewController: UIViewController {

    var currentUser = PFUser.current()
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var userNameField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.text = currentUser!.username
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 3
        userImage.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfilePictureButton(_ sender: UIButton) {
    }
    
    @IBAction func submitPasswordButton(_ sender: UIButton) {
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
