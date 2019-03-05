//
//  GuessDoodleViewController.swift
//
//  Created by Andy Tran Nguyen on 3/1/19.
//

import UIKit

class GuessDoodleViewController: UIViewController {

    @IBOutlet weak var timeLeftLabel: UILabel!
    
    // take user input in textfield
    @IBOutlet weak var playerInput: UITextField!
    
    // will display if user input is correct
    @IBOutlet weak var submissionCheck: UILabel!
    
    var guessTimer = 20
    var guessTime = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        guessTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GuessDoodleViewController.guessCounter), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    @objc func guessCounter()
    {
        guessTimer -= 1
        timeLeftLabel.text = "\(guessTimer) seconds left"
        
        if(guessTimer == 0)
        {
            guessTime.invalidate()
        }
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "guessToScore", sender: self)
        
    }
    
    // When user presses the "submit" button, their answer will be checked
    @IBAction func checkPlayerSubmission(_ sender: Any) {
        
        let userSubmission = playerInput.text
        let testString = "chicken"
        
        if userSubmission == testString
        {
            submissionCheck.text = "Correct Answer"
        }
        else{
            submissionCheck.text = "Inccorect Answer"
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

}
