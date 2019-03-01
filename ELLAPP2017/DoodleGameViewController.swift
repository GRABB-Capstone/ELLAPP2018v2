//
//  DoodleViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 2/24/16. Edited by Nick Ponce
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit

class DoodleGameViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var vocabLabel: UILabel!
    
    // edits from 01 / 29
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    // edits from 01 / 29
    
    var words = [String]()
    var currentWord = 0
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    // edits from 01 / 29
    var gameInt = 30
    var startInt = 3
    var gameTimer = Timer()
    var startTimer = Timer()
    //edits from 01 / 29
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // GRABB's pop-up is not supported by the Ellokids - NAP
//        let _ = SCLAlertView().showInfo("Word Doodle", subTitle: "Illustrate the meaning of the word. Click next to draw the next word!")
//
        // edits from 01 / 29
        gameInt = 30
        timeLabel.text = String(gameInt)
        startInt = 3
        button.setTitle(String(startInt), for: .normal)
        button.isEnabled = false
        let timer = Timer.scheduledTimer(timeInterval: 34.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DoodleGameViewController.startGame), userInfo: nil, repeats: true)
        // edits from 01 / 29
        
        if (words.count > 0) {
            currentWord = Int(arc4random_uniform(UInt32(words.count)))
            vocabLabel.text = words[currentWord]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    // The next 4 functions are not yet supported by the Ellokids - NAP
//    @IBAction func reset(_ sender: AnyObject) {
//        mainImageView.image = nil
//    }
//
//    @IBAction func resetImage(_ sender: AnyObject) {
//        mainImageView.image = nil
//    }
//
//    @IBAction func nextWord(_ sender: AnyObject) {
//        if words.count - 1 == currentWord {
//            currentWord = 0
//        }
//        else {
//            currentWord += 1
//        }
//
//        if (words.count > 0) {
//            vocabLabel.text = words[currentWord]
//        }
//    }
//
//    @IBAction func share(_ sender: AnyObject) {
//        UIGraphicsBeginImageContext(mainImageView.bounds.size)
//        mainImageView.image?.draw(in: CGRect(x: 0, y: 0,
//                                             width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        let activity = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
//        present(activity, animated: true, completion: nil)
//    }
    
    // Pencil
    @IBAction func colorChosen(_ sender: UIButton) {
        var index = sender.tag
        if index < 0 || index >= colors.count {
            index = 0
        }
        
        (red, green, blue) = colors[index]
        
        if index == colors.count - 1 {
            opacity = 1.0
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        context!.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context!.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        context!.setLineCap(CGLineCap.round)
        context!.setLineWidth(brushWidth)
        context!.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context!.setBlendMode(CGBlendMode.normal)
        
        // 4
        context!.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     let settingsViewController = segue.destinationViewController as! SettingsViewController
     settingsViewController.delegate = self
     settingsViewController.brush = brushWidth
     settingsViewController.opacity = opacity
     settingsViewController.red = red
     settingsViewController.green = green
     settingsViewController.blue = blue
     }
     
     }
     
     extension ViewController: SettingsViewControllerDelegate {
     func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
     self.brushWidth = settingsViewController.brush
     self.opacity = settingsViewController.opacity
     self.red = settingsViewController.red
     self.green = settingsViewController.green
     self.blue = settingsViewController.blue
     }
     }*/
    
    //edits from 01 / 29
    @objc func startGame()
    {
        startInt -= 1
        button.setTitle(String(startInt), for: .normal)
        
        if startInt == 0
        {
            startTimer.invalidate()
            button.setTitle("GO go go, DRAW before time runs out!!", for: .normal)
            button.isEnabled = true
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DoodleGameViewController.game), userInfo: nil, repeats: true)
        }
    }
    
    @objc func game()
    {
        gameInt -= 1
        timeLabel.text = String(gameInt)
        
        if gameInt == 0
        {
            gameTimer.invalidate()
            button.isEnabled = false
        }
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "PostSubmitScreen", sender: self)
    }
    // edits from 01/ 29
    
    // edits 02 / 13
    // attempting to take screenshot of drawing
    @IBAction func takeshot(_ sender: Any) {
        var image :UIImage?
        let currentLayer = UIApplication.shared.keyWindow!.layer
        let currentScale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale);
        guard let currentContext = UIGraphicsGetCurrentContext() else {return}
        currentLayer.render(in: currentContext)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let img = image else { return }
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)    }

}

