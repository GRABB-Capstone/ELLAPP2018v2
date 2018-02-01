//
//  BooksViewController.swift
//  test
//
//  Created by Grant Holstein on 1/28/18.
//  Copyright © 2018 Grant Holstein. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    @IBOutlet weak var booksCollectionView: UICollectionView!
    var books = Book.fetchBooks()
    let bookScale: CGFloat = 0.6
    
    @IBOutlet weak var nameLabel: UILabel!
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension BooksViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count //returns the number of books fetched
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //BREAKS HERE
        let cell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "myBook", for: indexPath) as! BookCollectionViewCell
        cell.book = books[indexPath.item] //creates cell for each book
        
        
        
        return cell
    }
}

