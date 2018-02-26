//
//  parabolaTests.swift
//  parabolaTests
//
//  Created by Kaey on 22/02/18.
//  Copyright © 2018 Vishnu K. All rights reserved.
//

import XCTest

@testable import parabola

var systemUnderTest: MainViewController!


class parabolaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
		let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		
		//get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
		systemUnderTest = storyboard.instantiateViewController(withIdentifier: "MainViewControlller") as! MainViewController
		  _ = systemUnderTest.view
    }
	
	func testSUT_CanInstantiateViewController() {
		
		XCTAssertNotNil(systemUnderTest)
	}
	
	func testSUT_TableViewIsNotNilAfterViewDidLoad() {
		
		XCTAssertNotNil(systemUnderTest.tableView)
	}
	
	func testSUT_ProgressHUD(){
		XCTAssertNotNil(ProgressHUD(text:""))
	}
	
	func testSUT_ArticleTableViewCell(){
		XCTAssertNotNil(ArticleTableViewCell())
	}
	
	func testSUT_Article(){
		let article: Article = Article.init(json: ["title":"News Today","author":"News Today","url":"News Today","description":"News Today","urlToImage":"News Today","publishedAt":"News Today"])!
		XCTAssertEqual(article.title, "News Today")
	}
	
	
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
}
