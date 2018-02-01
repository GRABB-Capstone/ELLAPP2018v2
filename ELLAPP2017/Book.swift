//
//  Book.swift
//  test
//
//  Created by Grant Holstein on 1/28/18.
//  Copyright © 2018 Grant Holstein. All rights reserved.
//

import UIKit
import Parse

class Book
{
    var title = ""
    var bookImage: UIImage
    var vocabWords: [String]
    
    init(title: String, bookImage: UIImage, vocab: [String]) {
        self.title = title
        self.bookImage = bookImage
        self.vocabWords = vocab
    }

}

