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
    var bonusCounter = 1
    var hud:MBProgressHUD?
    
    var backgroundImage = UIImageView()
    var scoreImage = UIImageView()
    var scoreLabel = UILabel()
    var timerImage = UIImageView()
    var timeLabel = UILabel()
    var randomNumberImage = UIImageView()
    var randomNumberLabel = UILabel()
    var userInput = UITextField()
    var explinationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        updateScoreLabel()
        updateTimeLabel()
        
        hud = MBProgressHUD(view:self.view)
        userInput.becomeFirstResponder()
        if(hud != nil) {
            self.view.addSubview(hud!)
        }
        
        userInput.addTarget(self, action: #selector(textDidChange(textField:)), for:UIControlEvents.editingChanged)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubViews()
    }
    
    func setupSubViews() {
        setupBackgroundImage()
        setupScoreImage()
        setupScoreLabel()
        setupTimerImage()
        setupTimeLabel()
        setupRandomNumberImage()
        setupRandomNumberLabel()
        setupUserInputText()
        setupExplinationLabel()
    }
    
    func layoutSubViews() {
        layoutBackgroundImage()
        layoutScoreImage()
        layoutScoreLabel()
        layoutTimerImage()
        layoutTimeLabel()
        layoutRandomNumberImage()
        layoutRandomNumberLabel()
        layoutUserInputText()
        layoutExplinationLabel()
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
    
    func setupScoreLabel() {
        scoreLabel.text = String(userScore)
        scoreLabel.textColor = UIColor.white
        scoreLabel.font = UIFont(name: "HVDComicSerifPro", size: 20)
        scoreLabel.contentMode = .scaleAspectFit
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scoreImage.addSubview(scoreLabel)
    }
    
    func layoutScoreLabel() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: scoreImage.topAnchor, constant: 5.0),
            scoreLabel.leadingAnchor.constraint(equalTo: scoreImage.leadingAnchor, constant: 55.0),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40.0),
            scoreLabel.widthAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    func setupTimerImage() {
        timerImage.image = UIImage(named: "time")
        timerImage.contentMode = .scaleAspectFit
        timerImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timerImage)
    }
    
    func layoutTimerImage() {
        NSLayoutConstraint.activate([
            timerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            timerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            timerImage.heightAnchor.constraint(equalToConstant: 50.0),
            timerImage.widthAnchor.constraint(equalToConstant: 140.0)
            ])
    }
    
    func setupTimeLabel() {
        timeLabel.font = UIFont(name: "HVDComicSerifPro", size: 20)
        timeLabel.textColor = UIColor.white
        timeLabel.contentMode = .scaleAspectFit
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
       
        
        timerImage.addSubview(timeLabel)
    }
    
    func layoutTimeLabel() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: timerImage.topAnchor, constant: 5.0),
            timeLabel.leadingAnchor.constraint(equalTo: timerImage.leadingAnchor, constant: 30.0),
            timeLabel.heightAnchor.constraint(equalToConstant: 40.0),
            timeLabel.widthAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    func setupRandomNumberImage() {
        randomNumberImage.image = UIImage(named: "number")
        randomNumberImage.contentMode = .scaleAspectFit
        randomNumberImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(randomNumberImage)
    }
    
    func layoutRandomNumberImage() {
        NSLayoutConstraint.activate([
            randomNumberImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.2),
            randomNumberImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.13),
            randomNumberImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            randomNumberImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75)
            ])
    }
    
    func setupRandomNumberLabel() {
        randomNumberLabel.text = getRandomNumber()
        randomNumberLabel.textAlignment = .center
        randomNumberLabel.textColor = UIColor.brown
        randomNumberLabel.font = UIFont(name: "HVDComicSerifPro", size: 77)
        randomNumberLabel.contentMode = .scaleAspectFit
        randomNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        randomNumberImage.addSubview(randomNumberLabel)
    }
    
    func layoutRandomNumberLabel() {
        NSLayoutConstraint.activate([
            randomNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.21),
            randomNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.13),
            randomNumberLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            randomNumberLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75)
            ])
    }
    
    func setupUserInputText() {
        let myColor : UIColor = UIColor.lightGray
        let blueColor = UIColor(hexString: "#6495ed")
        userInput.backgroundColor = UIColor.clear
        userInput.borderStyle = .roundedRect
        userInput.textAlignment = .center
        userInput.font = UIFont(name: "HVDComicSerifPro", size: 77)
        userInput.layer.borderColor = myColor.cgColor
        userInput.textColor = blueColor
        userInput.keyboardType = .numberPad
        userInput.contentMode = .scaleAspectFit
        userInput.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userInput)
    }
    
    func layoutUserInputText() {
        NSLayoutConstraint.activate([
            userInput.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.47),
            userInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.25),
            userInput.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13),
            userInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5)
            ])
    }
    
    func setupExplinationLabel() {
        explinationLabel.text = "Add 1 to each of the digits. So, 1357 becomes 2468."
        explinationLabel.numberOfLines = 2
        explinationLabel.textAlignment = .center
        explinationLabel.textColor = UIColor.white
        explinationLabel.font = UIFont(name: "HVDComicSerifPro", size: 20)
        explinationLabel.contentMode = .scaleAspectFit
        explinationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(explinationLabel)
    }
    
    func layoutExplinationLabel() {
        NSLayoutConstraint.activate([
            explinationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.75),
            explinationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15),
            explinationLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            explinationLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75)
            ])
    }
    
    
    @objc func textDidChange(textField:UITextField) {
        if userInput.text?.count == count {
            if  let numberLabel    = randomNumberLabel.text,
                let userInputText      = userInput.text,
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
                if(userScore > 0) {
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
                bonusCounter = 1
                userInput.text = ""
                updateTimeLabel()
                updateScoreLabel()
                setupRandomNumberLabel()
            }
        }
    }

    func updateTimeLabel() {
        print(bonusCounter)
    
        if(bonusCounter == 5) {
            seconds = 15
        }
        if(timeLabel != nil) {
            let minutes:Int = (seconds / 60) % 60
            let second:Int = seconds % 60

            let minutesPassed:String = String(format: "%02d", minutes)
            let secondsPassed:String = String(format: "%02d", second)

            timeLabel.text = "\(minutesPassed):\(secondsPassed)"
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

            userInput.text = ""

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hud?.hide(animated: true)
            }
        }
    }

    func updateScoreLabel() {
        scoreLabel.text = "\(userScore)"

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

