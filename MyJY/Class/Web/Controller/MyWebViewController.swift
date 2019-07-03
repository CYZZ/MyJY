//
//  MyWebViewController.swift
//  MyJY
//
//  Created by chiyz on 2019/7/3.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class MyWebViewController: UIViewController {
	
	var url  = String(){
		didSet{
			myweb.url = url
			UserDefaults().setValue(url, forKey: catcheUrlKey)
		}
	}
	
	private let catcheUrlKey = "catcheUrlKey"
	
	lazy var myweb: MyWebView = {
		let  myweb = MyWebView(frame: self.view.bounds)
		return myweb
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .white
		self.view.addSubview(self.myweb)

		self.setupNav()
		self.getCatchUrl()
    }
	/// 获取缓存的url
	private func getCatchUrl() {
		let defaults = UserDefaults()
		if let url = defaults.value(forKey: catcheUrlKey) {
			self.url = url as! String
		} else {
			self.url = "http://www.baidu.com"
		}
	}
	
	/// 初始化导航栏
	private func setupNav() -> Void {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(rightItemClick))
//		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(leftItemClick))
		let item1 = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(leftItemClick))
		let item2 = UIBarButtonItem.init(title: "拷贝链接", style: .plain, target: self, action: #selector(copyUrlClick))
		self.navigationItem.leftBarButtonItems = [item1,item2]
	}
	
	@objc func rightItemClick() -> Void {
		print("点击了右边的导航按钮")
		let secondVC = SeconViewController()
		secondVC.callback = {
			url in
			print("回调回来的url = \(url)")
			self.url = url
		}
		self.navigationController?.pushViewController(secondVC, animated: true)
	}
	
	@objc func leftItemClick() -> Void {
		print("点击了左边的导航按钮")
		self.myweb.reloadWebView()
	}
	
	// 拷贝地址
	@objc func copyUrlClick() {
		
		UIPasteboard.general.string = self.myweb.webView.url?.absoluteString
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.myweb.frame = self.view.bounds
	}
}
