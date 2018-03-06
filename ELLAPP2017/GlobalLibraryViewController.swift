//
//  GlobalLibraryViewController.swift
//  ELLAPP2017
//
//  Created by Nick Ponce on 1/23/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import UIKit
import Parse

class GlobalLibraryViewController: UIViewController {

    @IBOutlet weak var globalLibraryTableView: UITableView!
    
    var titles = [String]()
    var authors = [String]()
    var coverPictures = [PFFile]()
    var selectedTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Get all book objects and extract their data into arrays
        getAllBooks() {
            (books: [PFObject]) in
            for book in books {
                self.titles.append(book["name"] as! String)
                self.authors.append(book["author"] as! String)
                self.coverPictures.append(book["coverPicture"] as! PFFile)
                
                self.globalLibraryTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Support functions -> To be replaced by modular functions - NAP
    
    func getAllBooks(completion: @escaping (_ result: [PFObject]) -> Void) {
        // Get the PFQuery<Object> for the Books class
        let bookQuery = PFQuery(className: "Book")
        
        bookQuery.findObjectsInBackground(block: { (books: [PFObject]?, error: Error?) -> Void in
            if let result = books {
                completion(result)
            }
            else {
                completion([])
            }
        })
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

extension GlobalLibraryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = globalLibraryTableView.dequeueReusableCell(withIdentifier: "global_library_cell", for: indexPath) as? GlobalLibraryTableViewCell
        
        // Add cell initialization
        cell?.globalBookTitleLabel.text = titles[indexPath.row]
        cell?.globalAuthorLabel.text = authors[indexPath.row]
        
        cell?.globalCoverPictureImageView.image = UIImage(named: "placeholder.jpg")
        cell?.globalCoverPictureImageView.file = coverPictures[indexPath.row]
        cell?.globalCoverPictureImageView.loadInBackground()
        
        return cell!
    }
    
}
extension GlobalLibraryViewController: UITableViewDelegate {
    
}
