//
//  LoginViewController.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// Login without any crdentials, debug mode
	@IBAction func onLogin(_ sender: Any) {
		self.performSegue(withIdentifier: "main", sender: self)
	}
	
}

