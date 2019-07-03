//
//  MainTabBarViewController.swift
//  MyJY
//
//  Created by chiyz on 2019/7/3.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

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

}
