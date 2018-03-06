//
//  StudentInfoViewController.swift
//  ELLAPP2017
//
//  Created by Grant Holstein on 2/14/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import UIKit

class StudentInfoViewController: UIViewController {


    
    @IBOutlet weak var studentPicture: UIImageView!
    @IBOutlet weak var englishLevel: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var gradeLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //studentName.text = //make call for students name
        //englishLevel.text = //make call for student's english level
        //gradeLevel.text = //make call for student's grade level
        //                  //make call for image of student
        
        
        // Make image circular
        studentPicture.layer.cornerRadius = studentPicture.frame.size.width / 2
        studentPicture.clipsToBounds = true
        studentPicture.layer.borderWidth = 3
        studentPicture.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
