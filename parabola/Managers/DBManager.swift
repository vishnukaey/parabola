//
//  DBManager.swift
//  parabola
//
//  Created by Kaey on 25/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBManager {
	
	static let sharedInstance = DBManager()
	
	func getArticles(onSuccess: @escaping(Any) -> Void, onFailure: @escaping(Error) -> Void){
		var oarticles: [NSManagedObject]
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		let managedContext =
			appDelegate.persistentContainer.viewContext
  
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "OArticle")
  
		do {
			oarticles = try managedContext.fetch(fetchRequest)
			var articles:[Article] = []
			for oarticle in oarticles
			{
				let a:OArticle = oarticle as! OArticle
				let jsonObject: [String: Any] = ["title":a.title! as Any, "description":a.articleDescription! as Any, "author":a.author! as Any, "urlToImage":a.urlToImage! as Any, "url":a.url! as Any,"publishedAt":a.publishedAt! as Any]
				let article:Article = Article.init(json: jsonObject)!
				articles.append(article)
			}
			onSuccess(articles)
		} catch let error as NSError {
			onFailure(error)
		}
	}
	
	
	func saveArticles(categories:[Article]){
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "OArticle",
	                           in: managedContext)!
		
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "OArticle")
		
		do {
			let items = try managedContext.fetch(fetchRequest)
			for item in items {
				managedContext.delete(item)
			}
		} catch let error as NSError {
			print(error.localizedDescription)
		}
		
			
		for article in categories{
			
			let articleo = NSManagedObject(entity: entity,
			                               insertInto: managedContext)
			articleo.setValue(article.title, forKeyPath: "title")
			articleo.setValue(article.articleDescription, forKeyPath: "articleDescription")
			articleo.setValue(article.author, forKeyPath: "author")
			articleo.setValue(article.urlToImage, forKeyPath: "urlToImage")
			articleo.setValue(article.url, forKeyPath: "url")
			articleo.setValue(article.publishedAt, forKeyPath: "publishedAt")
		}
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
}
