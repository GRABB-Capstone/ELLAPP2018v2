
//
//  LocalLibraryViewController.swift
//  ELLAPP2017
//
//  Created by Nick Ponce on 1/23/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import UIKit
import Parse

class LocalLibraryViewController: UIViewController {
    
    @IBOutlet weak var localLibraryTableView: UITableView!
    
    var BooksArray: [PFObject] = []
    var titles = [String]()
    var authors = [String]()
    var coverPictures = [PFFile]()
    var selectedTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Get all book objects and extract their data into arrays
        Books().getLocalBooks(teacher: PFUser.current()!).then{ books in
            for book in books {
                self.titles.append(book["name"] as! String)
                self.authors.append(book["author"] as! String)
                self.coverPictures.append(book["coverPicture"] as! PFFile)
                //                self.globalLibraryTableView.reloadData()
            }
            self.BooksArray = books
            self.localLibraryTableView.reloadData()
            }.catch { error in
                // Error handling
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if (segue.identifier == "sw_locallib_to_book")
        {
            let destVC = segue.destination as? BookInfoViewController
            destVC?.currBook = self.BooksArray[localLibraryTableView.indexPathForSelectedRow!.row]
        }
     }
     
    
}

extension LocalLibraryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Number of sections called")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = localLibraryTableView.dequeueReusableCell(withIdentifier: "local_library_cell", for: indexPath) as? LocalLibraryTableViewCell
        
        // Add cell initialization
        cell?.localBookTitleLabel.text = titles[indexPath.row]
        cell?.localAuthorLabel.text = authors[indexPath.row]
        
        cell?.localCoverPictureImageView.image = UIImage(named: "placeholder.jpg")
        cell?.localCoverPictureImageView.file = coverPictures[indexPath.row]
        cell?.localCoverPictureImageView.loadInBackground()
        
        return cell!
    }
}

extension LocalLibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sw_locallib_to_book", sender: nil)
    }
}

