//
//  DetailViewController.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	var article:Article?
	@IBOutlet weak var titleLabel : UILabel?
	@IBOutlet weak var author : UILabel?
	@IBOutlet weak var articleDescription : UILabel?
	@IBOutlet weak var articleImageView: UIImageView?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel?.text = article?.title
		self.titleLabel?.text = article?.title
		self.articleDescription?.text = article?.articleDescription
		self.articleImageView?.downloadedFrom(link: (article?.urlToImage)!)

	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

