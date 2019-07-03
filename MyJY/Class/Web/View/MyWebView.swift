//
//  MyWebView.swift
//  MyJY
//
//  Created by chiyz on 2019/7/3.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import WebKit

class MyWebView: UIView {
	
	var url  = String(){
		didSet{
			webView.load(URLRequest(url: URL(string: url)!))
		}
	}
	
	
	/// 网页
	lazy var webView: WKWebView = {
		let webView = WKWebView(frame: self.bounds)
		return webView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.addSubview(self.webView)
	}
	
	func reloadWebView() -> Void {
		self.webView.reload()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.webView.frame = self.frame
	}
	
}
