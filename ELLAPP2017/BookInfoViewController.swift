//
//  BookInfoViewController.swift
//  ELLAPP2017
//
//  Created by Grant Holstein on 3/1/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import UIKit
import Parse

class BookInfoViewController: UIViewController {

    
    var Book = PFObject(className: "Book")
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookLevel: UILabel!
    var author = String()
    var grade = String()
    
    @IBOutlet weak var bookImage: PFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        author = Book["author"] as! String
        grade = Book["gradeLevel"] as! String
        
        bookTitle.text! = Book["name"] as! String//make call for book title
        bookAuthor.text = "Author: \(author)"//make call for book author
        bookLevel.text = "Grade Level: \(grade)"//make call for book grade level
        bookImage.file = Book["coverPicture"] as! PFFile!//make call for book image
        
        
        
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
