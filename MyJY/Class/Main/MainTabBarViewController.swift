//
//  MainTabBarViewController.swift
//  MyJY
//
//  Created by chiyz on 2019/7/3.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
	
	/// 前一个Item，用于记录是否切换
	private var prevItem = UITabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
		let tabbar = UITabBar.appearance()
		tabbar.tintColor = UIColor.orange
		addChildViewControllers()
    }
	
	/// 添加所有子控制器
	private func addChildViewControllers() -> Void {
		setChildViewController(MyWebViewController(), title: "首页", imageName: "home",systemItem: .history,tag: 0)
		setChildViewController(MyWebViewController(), title: "资讯", imageName: "home",systemItem: .bookmarks,tag: 1)
		setChildViewController(MyWebViewController(), title: "视频", imageName: "home",systemItem: .downloads,tag: 0)
		setChildViewController(MyWebViewController(), title: "活动", imageName: "home",systemItem: .favorites,tag: 0)
		setChildViewController(MyWebViewController(), title: "我", imageName: "home",systemItem: .contacts,tag: 0)
	}

	/// 初始化子控制器
	private func setChildViewController(_ childController:UIViewController, title:String,imageName:String,systemItem:UITabBarItem.SystemItem,tag:Int) {
		
		childController.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: tag)
		childController.title = title
		self.addChild(MyNavController(rootViewController: childController))
	}

	
	/// 设置导航栏和tabBar的显示状态
	///
	/// - Parameter isHiden: 为ture就隐藏，为false就显示
	func hidenTabBarAndNav(_ isHiden:Bool) -> Void {
		if isHiden {
			let Nav = self.selectedViewController as! MyNavController
			UIView.animate(withDuration: 0.25, animations: {
				//				Nav.navigationBar.isHidden = true
				self.tabBar.isHidden = true
			}) { (comple) in
				
			}
			Nav.setNavigationBarHidden(true, animated: true)
		} else {
			let Nav = self.selectedViewController as! MyNavController
			UIView.animate(withDuration: 0.25, animations: {
				//				Nav.navigationBar.isHidden = true
				self.tabBar.isHidden = false
			}) { (comple) in

			}
			Nav.setNavigationBarHidden(false, animated: true)
		}
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hidenTabBarAndNav"), object: self, userInfo: ["isHiden":isHiden])
	}
}

extension MainTabBarViewController {
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		if item == self.prevItem {
			print("点击了重复的按钮")
			self.hidenTabBarAndNav(true)
		} else {
			print("切换了tab按钮")
			self.prevItem = item
		}
	}
}
