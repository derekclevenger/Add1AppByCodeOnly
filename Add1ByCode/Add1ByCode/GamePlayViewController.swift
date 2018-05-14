//
//  ViewController.swift
//  Add1ByCode
//
//  Created by Derek Clevenger on 5/13/18.
//  Copyright © 2018 Derek Clevenger. All rights reserved.
//

import UIKit
import MBProgressHUD

class GamePlayViewController: UIViewController {
    
    var userScore:Int = 0
    var timer:Timer?
    var seconds:Int = 0
    var count = 2
    var numberToCheck = 11
    var bonus = false
    var bonusCounter = 0
    var hud:MBProgressHUD?
    
    var backgroundImage = UIImageView()
    var scoreImage = UIImageView()
    var scoreText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
        setupRandomNumberLabel()
        updateScoreLabel()
        updateTimeLabel()
        
        hud = MBProgressHUD(view:self.view)
        
        if(hud != nil) {
            self.view.addSubview(hud!)
        }
        
        userInput?.addTarget(self, action: #selector(textDidChange(textField:)), for:UIControlEvents.editingChanged)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubViews()
    }
    
    func setupSubViews() {
        setupBackgroundImage()
        setupScoreImage()
        setupScoreText()
    }
    
    func layoutSubViews() {
        layoutBackgroundImage()
        layoutScoreImage()
        layoutScoreText()
    }
    
    
    func setupBackgroundImage() {
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImage)
    }
    
    func layoutBackgroundImage() {
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            backgroundImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
            ])
    }
    
    func setupScoreImage() {
        scoreImage.image = UIImage(named: "score")
        scoreImage.contentMode = .scaleAspectFit
        scoreImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scoreImage)
    }
    
    func layoutScoreImage() {
        NSLayoutConstraint.activate([
            scoreImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            scoreImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            scoreImage.heightAnchor.constraint(equalToConstant: 50.0),
            scoreImage.widthAnchor.constraint(equalToConstant: 150.0)
            ])
    }
    
    func setupScoreText() {
        scoreText.text = userScore
        scoreText.contentMode = .scaleAspectFit
        scoreText.translatesAutoresizingMaskIntoConstraints = false
        
        scoreImage.addSubview(scoreImage)
    }
    
    func layoutScoreText() {
        NSLayoutConstraint.activate([
            scoreText.topAnchor.constraint(equalTo: scoreImage, constant: 5.0),
            scoreText.leadingAnchor.constraint(equalTo: scoreImage.leadingAnchor, constant: 5.0),
            scoreText.heightAnchor.constraint(equalToConstant: 40.0),
            scoreText.widthAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    @objc func textDidChange(textField:UITextField) {
        //TODO make it so that the game ends and stops the timer after 5.  Add the score plus remaining time.  Change don't want to try and
        // do the bonus of time plus score.  the math would get fuzzy due to wrongs?
        if userInput?.text?.count == count {
            if  let numberLabel    = numbersLabel?.text,
                let userInputText      = userInput?.text,
                let number         = Int(numberLabel),
                let userInput           = Int(userInputText)
            {
                count = count != 5 ? count + 1 : 5
                bonusCounter += 1
                print("Comparing: \(userInputText) minus \(numberLabel) == \(userInput - number)")
                
                if(userInput - number == numberToCheck) {
                    
                    userScore += 1
                    
                    show(isRight: true)
                }
                else {
                    print("Incorrect!")
                    
                    userScore -= 1
                    
                    show(isRight: false)
                }
                
            }
            
            getNumberToCheck()
            setupRandomNumberLabel()
            updateScoreLabel()
            
            
            if(timer == nil) {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onTimeUpdate), userInfo:nil, repeats:true)
            }
        }
    }
    
    @objc func onTimeUpdate()
    {
        if(seconds >= 0 && seconds < 15) {
            seconds += 1
            updateTimeLabel()
        }
        else if(seconds == 15) {
            if(timer != nil) {
                timer!.invalidate()
                timer = nil
                if(bonus == true) {
                    userScore = userScore * 2
                }
                let alertController = UIAlertController(title: "Time Up!", message: "Your time is up! You got a score of: \(userScore) points. Very good!", preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
                alertController.addAction(restartAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                userScore = 0
                seconds = 0
                count = 2
                bonus = false
                updateTimeLabel()
                updateScoreLabel()
                setupRandomNumberLabel()
            }
        }
    }
    
    func updateTimeLabel() {
        if(bonusCounter == 5 && userScore != 0) {
            bonus = true
            seconds = 15
        }
        if(bonusCounter == 5) {
            seconds = 15
        }
        if(timeLabel != nil) {
            let minutes:Int = (seconds / 60) % 60
            let second:Int = seconds % 60
            
            let minutesPassed:String = String(format: "%02d", minutes)
            let secondsPassed:String = String(format: "%02d", second)
            
            timeLabel!.text = "\(minutesPassed):\(secondsPassed)"
        }
    }
    
    func show(isRight:Bool) {
        var imageView:UIImageView?
        
        if isRight {
            imageView = UIImageView(image: UIImage(named:"thumbs-up"))
        }
        else {
            imageView = UIImageView(image: UIImage(named:"thumbs-down"))
        }
        
        if(imageView != nil) {
            hud?.mode = MBProgressHUDMode.customView
            hud?.customView = imageView
            
            hud?.show(animated: true)
            
            self.userInput?.text = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hud?.hide(animated: true)
            }
        }
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = "\(userScore)"
        
    }
    
    func setupRandomNumberLabel() {
        numbersLabel?.text = getRandomNumber()
    }
    
    func getRandomNumber() -> String {
        var randomNumber:String = ""
        
        for _ in 1...count
        {
            let digit:Int = Int(arc4random_uniform(8) + 1)
            
            
            randomNumber += "\(digit)"
        }
        
        return randomNumber
    }
    
    func getNumberToCheck()  {
        var randomNum:String = ""
        
        for _ in 1...count
        {
            let digit:Int = Int(arc4random_uniform(1) + 1)
            
            randomNum += "\(digit)"
        }
        numberToCheck = Int(randomNum)!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

