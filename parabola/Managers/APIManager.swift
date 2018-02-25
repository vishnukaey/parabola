//
//  APIManager.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//


class APIManager {
	
	let baseURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=eb018d4f59a54cbb84704d6373d78365"
	
	static let sharedInstance = APIManager()
	
	func getArticles(onSuccess: @escaping(Any) -> Void, onFailure: @escaping(Error) -> Void){
		let manager = WebServiceManager.init()
		let url : String = baseURL
		manager.getHTTPRequestUsingParamsAndURL(urlString: url, onSuccess:{jsondata in onSuccess(self.parseJSON(jsondata: jsondata as! [String : Any]))},onFailure: {error in onFailure(error)})
	}
	
	func parseJSON(jsondata: [String: Any]) -> Any
	{
		var names = [Article]()
		if let blogs = jsondata["articles"] as? [[String: Any]] {
			for blog in blogs {
				if let article = Article(json: blog) {
					names.append(article)
				}
			}
		}
		return names
	}
}
