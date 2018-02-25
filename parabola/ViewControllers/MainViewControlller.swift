//
//  MainViewControlller.swift
//  parabola
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
	var articles:[Article] = []
	let progressHUD = ProgressHUD(text: "Getting List")
	var uiRefreshControl: UIRefreshControl!

	// MARK: - ViewController Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Tableview footer to remove unwanted separators
		self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
		
		//Add loading view
		self.view.addSubview(progressHUD)
		
		// Add pull to refresh
		uiRefreshControl = UIRefreshControl()
		uiRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		uiRefreshControl.addTarget(self, action: #selector(MainViewController.refresh), for: UIControlEvents.valueChanged)
		tableView.addSubview(uiRefreshControl) // not required when using UITableViewController
		
		
		//Get top articles from Live News feed
		getArticles()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	// MARK: - Methods
	
	func getArticles(){
		
		// Get news from API or DB based on connection status
		
		if Reachability.isConnectedToNetwork(){
			let manager = APIManager.sharedInstance
			manager.getArticles(onSuccess:{data in self.success(data: data)}, onFailure: { error in	self.failure(error: error)	})
		}else{
			let manager = DBManager.sharedInstance
			manager.getArticles(onSuccess:{data in self.success(data: data)}, onFailure: { error in	self.failure(error: error)	})
		}
	}
	
	//Pull to refresh action
	func refresh(){
		getArticles()
	}

	
	// on successful data loading from API or DB, update the DB
	func success(data: Any)
	{
		uiRefreshControl.endRefreshing()
		articles = data as! [Article]
		let manager = DBManager.sharedInstance
		
		//save results to DB if loaded from API
		if Reachability.isConnectedToNetwork(){
			manager.saveArticles(categories: data as! [Article])
		}
		DispatchQueue.main.async {
			self.tableView.reloadData()
			self.progressHUD.removeFromSuperview()
		}
	}
	
	func failure(error: Error)
	{
		progressHUD.removeFromSuperview()
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
		self.show(alert, sender: nil)
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "detail")
		{
			let controller:DetailViewController = segue.destination as! DetailViewController
			controller.article = sender as? Article
		}
	}
	
	
	// Logout Action
	@IBAction func logOut(_ sender: Any) {
		
		let alertController = UIAlertController(title: nil, message: "Logout of Parabola?", preferredStyle: .alert)
		
		// Create the actions
		let okAction = UIAlertAction(title: "Logout", style: UIAlertActionStyle.destructive) {
			UIAlertAction in
			self.navigationController?.popToRootViewController(animated: true)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
			UIAlertAction in
			
		}
		// Add the actions
		alertController.addAction(okAction)
		alertController.addAction(cancelAction)
		
		// Present the controller
		self.present(alertController, animated: true, completion: nil)		
	}
	
	
	// MARK: - Tableview datasource delegate
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articles.count;
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ArticleTableViewCell {
		let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! ArticleTableViewCell
		cell.title?.text = articles[indexPath.row].title
		cell.author?.text = articles[indexPath.row].author
		cell.selectionStyle = UITableViewCellSelectionStyle.none
		cell.articleImageView?.downloadedFrom(link: articles[indexPath.row].urlToImage)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "detail", sender: articles[indexPath.row])
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120.0
	}

}

