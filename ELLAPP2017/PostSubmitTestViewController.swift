//
//  PostSubmitTestViewController.swift
//  ELLAPP2017
//
//  Created by Andy Tran Nguyen on 2/11/19.
//  Copyright © 2019 Ellokids. All rights reserved.
//

import UIKit

class PostSubmitTestViewController: UIViewController {
    
    @IBOutlet weak var waitLabel: UILabel!
    
    var waitInt = 5
    var waitTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        waitTimer = Timer.init(timeInterval: 1, target: self, selector: #selector(PostSubmitTestViewController.waitCount), userInfo: nil, repeats: true)
        waitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PostSubmitTestViewController.waitCount), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    @objc func waitCount()
    {
        waitInt -= 1
        waitLabel.text = "\(waitInt) seconds left"
        if (waitInt == 0)
        {
            waitTimer.invalidate()
        }
    }
    
    // Makes players wait an alloted amount of time after submitting their drawings before
    // segueing into a new scene
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "guessDrawing", sender: self)
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
