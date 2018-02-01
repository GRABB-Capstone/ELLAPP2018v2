//
//  Book.swift
//  test
//
//  Created by Grant Holstein on 1/28/18.
//  Copyright © 2018 Grant Holstein. All rights reserved.
//

import UIKit

class Book
{
    var title = ""
    var bookImage: UIImage
    init(title: String, bookImage: UIImage) {
        self.title = title
        self.bookImage = bookImage
    }
    static func fetchBooks() -> [Book]
    {
        //Fetch the books from the database
        return [
            Book(title: "Goodnight Moon", bookImage: UIImage(named: "goodnight.jpg")!),
            Book(title: "The Rainbow Fish", bookImage: UIImage(named: "the-rainbow-fish.jpg")!)
        ]
    }
}

