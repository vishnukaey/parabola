//
//  ArticleTableViewwCell.swift
//  parabola
//
//  Created by Kaey on 25/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
	@IBOutlet var title : UILabel?
	@IBOutlet var author : UILabel?
	@IBOutlet var articleImageView: UIImageView?
	@IBOutlet var moreButton: UIButton?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

// extensoin to imageview to load image from a given URLString

extension UIImageView {
	func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() {
				self.image = image
			}
			}.resume()
	}
	func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else { return }
		downloadedFrom(url: url, contentMode: mode)
	}
}
