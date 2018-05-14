//
//  GamePlayViewController.swift
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
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.08),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 60.0),
            backgroundImage.widthAnchor.constraint(equalToConstant: 150.0)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
