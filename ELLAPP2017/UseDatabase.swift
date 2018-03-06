//
//  UseDatabase.swift
//  ELLAPP2017
//
//  Created by Christopher Peterson on 2/14/18.
//  Copyright © 2018 Ellokids. All rights reserved.
//

import Foundation
import Hydra
import Parse

class UseDatabase{
    // Logs in with a username and password
    // Returns the user who logged in
    func login(user: String, pass: String) -> Promise<PFUser> {
        return Promise<PFUser>(in: .background, { resolve, reject, _ in
            // Just call Parse's login function and handle any errors
            PFUser.logInWithUsername(inBackground: user, password: pass, block: {
                (result : PFUser?, error: Error?) -> Void in
                
                if let result = result {
                    resolve(result)
                }
                else {
                    reject(error!)
                }
            })
        })
    }
    
    // Returns the classrooms associated with a user
    func getClassrooms(user: PFUser) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let classroomQuery = PFQuery(className: "ClassroomUserIntermediate")
            classroomQuery.whereKey("user", equalTo: user)
            
            // Query it and fetch the results
            self.queryIntermediate(query: classroomQuery, key: "classroom").then(self.fetchAll).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the books in the global library, isPublic = true
    func getGlobalBooks() -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let globalBookQuery = PFQuery(className: "Book")
            globalBookQuery.whereKey("isPublic", equalTo: true)
            
            // Query it
            self.simpleQuery(query: globalBookQuery).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the books in a teacher's personal library:
    // isPublic = false, owner = this teacher
    func getTeacherBooks(teacher: PFUser) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let teacherBookQuery = PFQuery(className: "Book")
            teacherBookQuery.whereKey("isPublic", equalTo: false)
            teacherBookQuery.whereKey("owner", equalTo: teacher)
            
            // Query it
            self.simpleQuery(query: teacherBookQuery).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the vocab words associated with a book
    func getVocabWords(book: PFObject) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let vocabQuery = PFQuery(className: "Vocab")
            vocabQuery.whereKey("book", equalTo: book)
            
            // Query it
            self.simpleQuery(query: vocabQuery).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the students associated with a classroom
    // isTeacher = false, classroom = this classroom
    func getStudentsInClassroom(classroom: PFObject) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let studentQuery = PFQuery(className: "ClassroomUserIntermediate")
            studentQuery.whereKey("isTeacher", equalTo: false)
            studentQuery.whereKey("classroom", equalTo: classroom)
            
            // Query it and fetch the results
            self.queryIntermediate(query: studentQuery, key: "user").then(self.fetchAll).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the teachers associated with a classroom
    // isTeacher = true, classroom = this classroom
    func getTeachersOfClassroom(classroom: PFObject) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let teacherQuery = PFQuery(className: "ClassroomUserIntermediate")
            teacherQuery.whereKey("isTeacher", equalTo: true)
            teacherQuery.whereKey("classroom", equalTo: classroom)
            
            // Query it and fetch the results
            self.queryIntermediate(query: teacherQuery, key: "user").then(self.fetchAll).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the books associated with a classroom
    func getBooksInClassroom(classroom: PFObject) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let bookQuery = PFQuery(className: "ClassroomBookIntermediate")
            bookQuery.whereKey("Classroom", equalTo: classroom)
            
            // Query it and fetch the results
            self.queryIntermediate(query: bookQuery, key: "Book").then(self.fetchAll).then{ res in
                resolve(res)
            }
        })
    }
    
    // Returns the games associated with a book & classroom
    func getGames(classroom: PFObject, book: PFObject) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            // Create the query
            let intermediateQuery = PFQuery(className: "ClassroomBookIntermediate")
            intermediateQuery.whereKey("Classroom", equalTo: classroom)
            intermediateQuery.whereKey("Book", equalTo: book)
            
            // Query it
            self.simpleQuery(query: intermediateQuery).then{ res in
                
                // If there isn't an intermediate, retrn an error
                if (res.count == 0){
                    let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No intermediate found"])
                    reject(err)
                }
                
                let intermediate = res[0]
                
                // Create the second query
                let gameQuery = PFQuery(className: "ClassroomBookGameIntermediate")
                gameQuery.whereKey("ClassroomBookIntermediate", equalTo: intermediate)
                
                // Query it and fetch the results
                self.queryIntermediate(query: gameQuery, key: "Game").then(self.fetchAll).then{ res in
                    resolve(res)
                }
            }
        })
    }
    
    // Attempts to remove object from the database
    func removeFromDatabase(object: PFObject) -> Promise<Bool> {
        return Promise<Bool>(in: .background, { resolve, reject, _ in
            object.deleteInBackground(block: { (result: Bool, error: Error?) -> Void in
                // If the database call is successful, return the result
                if error == nil {
                    resolve(result)
                }
                // Otherwise return the error
                else {
                    reject(error!)
                }
            })
        })
    }
    
    // Attempts to update the database with object
    func updateToDatabase(object: PFObject) -> Promise<Bool> {
        return Promise<Bool>(in: .background, { resolve, reject, _ in
            object.saveInBackground(block: { (result: Bool, error: Error?) -> Void in
                // If the database call is successful, return the result
                if error == nil {
                    resolve(result)
                }
                    // Otherwise return the error
                else {
                    reject(error!)
                }
            })
        })
    }
    
    // Calls a query on an intermediate in the database, and collects the resulting objects in an
    // array of PFObjects
    //
    // Query - The query object for the intermediates we want
    // Key - The key that corresponds to the field we want out of the intermediate
    func queryIntermediate(query: PFQuery<PFObject>, key: String) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            query.findObjectsInBackground(block: { (queryResult: [PFObject]?, error: Error?) -> Void in
                // If the query is successful, get the data from the correct field and return it
                if let queryResult = queryResult {
                    var results = [PFObject]()
                    
                    for item in queryResult {
                        let object = item[key] as! PFObject
                        results.append(object)
                    }
                
                    resolve(results)
                }
                // Otherwise return the error
                else {
                    reject(error!)
                }
            })
        })
    }
    
    // Does a query on the database in promise format
    func simpleQuery(query: PFQuery<PFObject>) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            query.findObjectsInBackground(block: { (queryResult: [PFObject]?, error: Error?) -> Void in
                // If the query is successful, return the result
                if let queryResult = queryResult {
                    resolve(queryResult)
                }
                // Otherwise return the error
                else {
                    reject(error!)
                }
            })
        })
    }
    
    // Fetches an arry of PFObjects from the database
    // Todo err and semaphores
    func fetchAll(objects: [PFObject]) -> Promise<[PFObject]> {
        return Promise<[PFObject]>(in: .background, { resolve, reject, _ in
            var results = [PFObject]()
            var total = 0
            for object in objects {
                object.fetchInBackground(block: { (result: PFObject?, error: Error?) -> Void in
                    results.append(result!)
                    total += 1
                    if total >= objects.count {
                        resolve(results)
                    }
                })
            }
        })
    }
}
