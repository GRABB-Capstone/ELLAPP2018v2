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
    
    var books = [Book]()
    let bookScale: CGFloat = 0.6
    
    var username = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(username)'s Books"
        let screenSize = UIScreen.main.bounds.size
        let bookWidth = floor(screenSize.width * bookScale)
        let bookHeight = floor(screenSize.height * bookScale)
        
        let insetX = (view.bounds.width - bookWidth) / 2.0
        let insetY = (view.bounds.height - bookHeight) / 4.0
        //print(bookWidth, bookHeight, insetX, insetY)
        let bookLayout = booksCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        bookLayout.itemSize = CGSize(width: bookWidth, height: bookHeight)
        booksCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        booksCollectionView?.dataSource = self
        
        booksCollectionView.allowsSelection = true
        
        
        // Look into "UICollectionView's two prefetching techniques"
        let booksQuery = PFQuery(className: "Book")
        
        booksQuery.findObjectsInBackground { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    // query the books from only the signed in user
                    let title = object["name"] as! String
                    let cover = object["coverPicture"] as! PFFile
                    let vocab = object["vocab"] as! [String]
                    
                    cover.getDataInBackground({ (data, error) -> Void in
                        if let coverImage = UIImage(data: data!) {
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
//        getAllBooks() {
//            (allBooks: [Book]) in
//            print("allBooks count: \(allBooks.count)")
//            for book in allBooks {
//                print("Final book: \(book.title)")
//                self.books.append(book)
//                print("Appending \(self.books.count) to main array")
//            }
//            print("2Number of books pre reload \(self.books.count)")
//            self.booksCollectionView.reloadData()
//            print("3Number of books post reload \(self.books.count)")
//        }
    }
    
    @IBAction func tempCellSelect(_ sender: UIButton) {
        performSegue(withIdentifier: "sw_doodle", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
//    func getAllBooks(completion: @escaping (_ result: [Book]) -> Void) {
//        var allBooks = [Book]()
//
//        getAllBookObjects() {
//            (books: [PFObject]) in
//            for book in books {
//                let title = book["name"] as! String
//                print("1This is the book title \(title)")
//                (book["coverPicture"] as! PFFile).getDataInBackground(block: { (cover, error) -> Void in
//                    if let downloadedImage = UIImage(data: cover!) {
//                        allBooks.append(Book(title: title, bookImage: downloadedImage))
//                        print("appending from get all book objects")
//                    }
//                    else {
//                        print("Book Image Error occured: \(error.debugDescription)")
//                    }
//                })
//            }
//            completion(allBooks)
//        }
//    }
//
//    func getAllBookObjects(completion: @escaping (_ result: [PFObject]) -> Void) {
//        // Get the PFQuery<Object> for the Books class
//        let bookQuery = PFQuery(className: "Book")
//
//        bookQuery.findObjectsInBackground(block: { (books: [PFObject]?, error: Error?) -> Void in
//            if let result = books {
//                completion(result)
//            }
//            else {
//                completion([])
//            }
//        })
//    }
    
}

//    func fetchBooks() -> [Book]
//    {
//        var allBooks = [Book]()
//        //Fetch the books from the database
//        getAllBooks() {
//            (books: [PFObject]) in
//            for book in books {
//                let title = book["name"] as! String
//                print("This is the book title \(title)")
//                (book["coverPicture"] as! PFFile).getDataInBackground(block: { (cover, error) -> Void in
//                    if let downloadedImage = UIImage(data: cover!) {
//                        allBooks.append(Book(title: title, bookImage: downloadedImage))
//                    }
//                    else {
//                        print("Book Image Error occured: \(error.debugDescription)")
//                    }
//                })
//            }
//            print("Number of books pre reload \(books.count)")
//            self.booksCollectionView.reloadData()
//            print("Number of books post reload \(books.count)")
//        }
//
//        return allBooks
//        // Demo collection view return items - NAP
//        //        return [
//        //            Book(title: "Goodnight Moon", bookImage: UIImage(named: "goodnight.jpg")!),
//        //            Book(title: "The Rainbow Fish", bookImage: UIImage(named: "the-rainbow-fish.jpg")!)
//        //        ]
//    }

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
        //BREAKS HERE
        let cell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "myBook", for: indexPath) as! BookCollectionViewCell
        
        cell.book = self.books[indexPath.item] //creates cell for each book
        
        return cell
    }
}

//extension BooksViewController: UICollectionViewDelegate
//{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Selected an item and it registered in the delegate function")
//        performSegue(withIdentifier: "sw_doodle", sender: nil)
//    }
//}

