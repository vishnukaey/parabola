//
//  WebServiceManager.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import Foundation
class WebServiceManager{
	var names = [Article]()
	func getHTTPRequestUsingParamsAndURL(urlString: String, onSuccess: @escaping(Any) -> Void, onFailure: @escaping(Error) -> Void){
		let session = URLSession(configuration: URLSessionConfiguration.default)
		if let usableUrl = URL(string:urlString as String){
			let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
				do {
					if let data = data,
						let jsondata = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
						onSuccess(jsondata)
					}
				} catch {
					onFailure(error)
				}
			})
			task.resume()
		}
	}
}
