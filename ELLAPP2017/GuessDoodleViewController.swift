//
//  GuessDoodleViewController.swift
//
//
//  Created by Andy Tran Nguyen on 3/1/19.
//

import UIKit

class GuessDoodleViewController: UIViewController {
    
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var guessTimer = 30
    var guessTime = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        guessTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GuessDoodleViewController.guessCounter), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
