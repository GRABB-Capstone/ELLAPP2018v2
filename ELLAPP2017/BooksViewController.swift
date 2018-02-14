//
//  BooksViewController.swift
//  test
//
//  Created by Grant Holstein on 1/28/18.
//  Copyright © 2018 Grant Holstein. All rights reserved.
//

import UIKit
import Parse

class BooksViewController: UIViewController {
    
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    /* Array of pulled books */
    var books = [Book]()
    let bookScale: CGFloat = 0.6
    
    var username = String()
    
   /* For the view to load we need to configure the collection view settings */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(username)'s Books"
        
        /* Setup the collection view's setting fields */
        let screenSize = UIScreen.main.bounds.size
        let bookWidth = floor(screenSize.width * bookScale)
        let bookHeight = floor(screenSize.height * bookScale)
        
        let insetX = (view.bounds.width - bookWidth) / 2.0
        let insetY = (view.bounds.height - bookHeight) / 4.0
        let bookLayout = booksCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        bookLayout.itemSize = CGSize(width: bookWidth, height: bookHeight)
        booksCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        booksCollectionView?.dataSource = self
        booksCollectionView?.delegate = self
        
        booksCollectionView.allowsSelection = true
        
        /* TODO: Look into "UICollectionView's two prefetching techniques" */
        let booksQuery = PFQuery(className: "Book")
        
        /* Asynchronous call to the database for book data pertaining to the user */
        booksQuery.findObjectsInBackground { (objects, error) -> Void in
            if let objects = objects {
                for book in objects {
                    /* Get what you need from each book */
                    let title = book["name"] as! String
                    let cover = book["coverPicture"] as! PFFile
                    let vocab = book["vocab"] as! [String]

                    /* Get the image from the PFFile */
                    cover.getDataInBackground({ (data, error) -> Void in
                        if let coverImage = UIImage(data: data!) {
                            /* Add the new books to the array and reload the data in the collection view */
                            self.books.append(Book(title: title, bookImage: coverImage, vocab: vocab))
                            self.booksCollectionView.reloadData()
                        }
                        else {
                            print("There was an image error: \(error.debugDescription)")
                        }
                    })
                }
            }
        }
    }
    
//    /* Temporary fix for Demo before doing a didSelect implementation */
//    @IBAction func tempCellSelect(_ sender: UIButton) {
//        performSegue(withIdentifier: "sw_doodle", sender: nil)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* This function prepares for the next segue by getting the indexpath for the selected  */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sw_doodle" {
            let destVC = segue.destination as? DoodleGameViewController
            
            print("selected items: \(self.booksCollectionView.indexPathsForSelectedItems!.count)")
            let selectedIndexPath = self.booksCollectionView.indexPathsForSelectedItems![0]
            
            print("Selected item number: \(selectedIndexPath.item) and book count: \(self.books.count)")
//            destVC?.words.append(self.books[selectedIndexPath.item].title)
            destVC?.words = self.books[selectedIndexPath.item].vocabWords
        }
    }
}

extension BooksViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("4Number of books \(self.books.count)")
        return self.books.count //returns the number of books fetched
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "myBook", for: indexPath) as! BookCollectionViewCell
        
        cell.book = self.books[indexPath.item] //creates cell for each book
        
        return cell
    }
}

extension BooksViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected an item and it registered in the delegate function")
        performSegue(withIdentifier: "sw_doodle", sender: nil)
    }
}

