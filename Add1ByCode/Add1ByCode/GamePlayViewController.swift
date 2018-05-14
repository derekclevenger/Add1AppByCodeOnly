//
//  ViewController.swift
//  Add1ByCode
//
//  Created by Derek Clevenger on 5/13/18.
//  Copyright © 2018 Derek Clevenger. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {

    var backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubViews()
    }
    
    func setupSubViews() {
        setupBackgroundImage()
    }
    
    func layoutSubViews() {
        layoutBackgroundImage()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

