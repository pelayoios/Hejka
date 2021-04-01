//
//  ViewController.swift
//  Hejka
//
//  Created by Miguel Pelayo Mercado Caram on 3/29/21.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "🦜Hejka"
    }


}

