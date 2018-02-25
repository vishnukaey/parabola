//
//  Dog.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import Foundation

struct Article {
	var title: String
	var articleDescription: String
	var author: String
	var urlToImage: String
	var url: String
	var publishedAt: String
	
	init?(json: [String: Any]) {
		guard let title = json["title"] as? String,
			let author = json["author"] as? String,
			let articleDescription = json["description"] as? String,
			let urlToImage = json["urlToImage"] as? String,
			let publishedAt = json["publishedAt"] as? String,
			let url = json["url"] as? String else {
				return nil
		}
		self.title = title
		self.author = author
		self.articleDescription = articleDescription
		self.urlToImage = urlToImage
		self.url = url
		self.publishedAt = publishedAt
	}
	
	func encode(with aCoder: NSCoder){
		aCoder.encode(title, forKey: "title")
		aCoder.encode(author, forKey: "author")
		aCoder.encode(articleDescription, forKey: "articleDescription")
		aCoder.encode(urlToImage, forKey: "urlToImage")
		aCoder.encode(url, forKey: "url")
		aCoder.encode(publishedAt, forKey: "publishedAt")
	}
}
