//
//  BookInfoViewController.swift
//  ELLAPP2017
//
//  Created by Grant Holstein on 3/1/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {


    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookLevel: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bookTitle.text = //make call for book title
        //bookAuthor.text = "Author: "//make call for book author
        //bookLevel.text = "Grade Level: "//make call for book grade level
        //                  //make call for book image
        
        
        
        // Make image circular
        //bookImage.layer.cornerRadius = bookImage.frame.size.width / 2
        bookImage.clipsToBounds = true
        bookImage.layer.borderWidth = 3
        bookImage.layer.borderColor = UIColor.white.cgColor
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
