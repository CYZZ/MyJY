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
	
	lazy var backButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "back"), for: .normal)
		button.addTarget(self, action: #selector(backButtonClick(_:)), for: .touchUpInside)
		return button
	}()
	
	lazy var forwardButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "forward"), for: .normal)
		button.addTarget(self, action: #selector(forwardButtonClick(_:)), for: .touchUpInside)
		return button
	}()
	
	lazy var contenView: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: self.frame.height*0.5, width: 100, height: 40))
		view.backgroundColor = UIColor.lightGray
		view.layer.cornerRadius = 5
		view.alpha = 0.5
		self.backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
		self.forwardButton.frame = CGRect(x: 50, y: 0, width: 50, height: 40)
		view.addSubview(self.backButton)
		view.addSubview(self.forwardButton)
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.addSubview(self.webView)
		self.setupView()
		NotificationCenter.default.addObserver(self, selector: #selector(tabBarHidenOrShow(_:)), name: NSNotification.Name(rawValue: "hidenTabBarAndNav"), object: nil)
	}
	
	@objc func tabBarHidenOrShow(_ notification:Notification) {
		let isHiden = notification.userInfo?["isHiden"] as! Bool
		let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarViewController
		let Nav = tabBarController.selectedViewController as! MyNavController
		
		UIView.animate(withDuration: 0.3, animations: {
			if isHiden {
				self.webView.scrollView.contentInset = UIEdgeInsets.zero
			} else {
				self.webView.scrollView.contentInset = UIEdgeInsets(top: Nav.navigationBar.frame.maxY, left: 0, bottom: tabBarController.tabBar.frame.height, right: 0)
			}
		}) { (comple) in
			
		}
		
	}
	
	/// 初始化悬浮球
	func setupView() -> Void {
		// 添加拖拽事件
//		UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
		let pan1 = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
		self.backButton.addGestureRecognizer(pan1)
		
		let pan2 = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
		self.forwardButton.addGestureRecognizer(pan2)
		
		self.addSubview(self.contenView)
	}
	
	@objc func handlePanGesture(_ p:UIPanGestureRecognizer) {
		
		let point = p.location(in: self)
		if p.state == .began {
			self.contenView.alpha = 1
			
		} else if p.state == .changed {
			self.contenView.center = CGPoint(x: point.x, y: point.y)
		} else if p.state == .ended || p.state == .cancelled {
			self.contenView.alpha = 0.5
			
			let left = abs(point.x)
			let right = abs(self.frame.width - left)
			
			var minSpace:CGFloat = 0.0
			minSpace = min(left, right)
			
			var newCenter = CGPoint.zero
			var targetY:CGFloat = 0
			if point.y < 100 {
				targetY = 100
			} else if point.y > (self.frame.height - 100) {
				targetY = self.frame.height - 100
			} else {
				targetY = point.y
			}
			
			
			if minSpace == left {
				newCenter = CGPoint(x: 50, y: targetY)
			} else {
				newCenter = CGPoint(x: self.frame.width - 50, y: targetY)
			}
			
			UIView.animate(withDuration: 0.25, animations: {
				self.contenView.center = newCenter
			}, completion: nil)
			self.showNavAndTabBar()
		} else {
			print("pan State = \(p.state)")
		}
		
	}
	
	func reloadWebView() -> Void {
		self.webView.reload()
	}
	
	@objc func backButtonClick(_ sender:UIButton) {
		if self.webView.canGoBack {
			self.webView.goBack()
		}
	}
	
	@objc func forwardButtonClick(_ sender:UIButton) {
		if self.webView.canGoForward {
			self.webView.goForward()
		}
	}
	/// 显示导航栏和tabBar
	private func showNavAndTabBar() -> Void {
		let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarViewController
		tabBarController.hidenTabBarAndNav(false)
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.webView.frame = self.frame
		self.contenView.center = CGPoint(x: 50, y: self.frame.height * 0.5)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
}
