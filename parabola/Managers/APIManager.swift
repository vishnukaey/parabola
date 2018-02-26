//
//  APIManager.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//


class APIManager {
		
	static let sharedInstance = APIManager()
	
	func getArticles(onSuccess: @escaping(Any) -> Void, onFailure: @escaping(Error) -> Void){
		let manager = WebServiceManager.init()
		let url : String = Constants.baseURL
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
