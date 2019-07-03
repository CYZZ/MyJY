//
//  MyNavController.swift
//  MyJY
//
//  Created by chiyz on 2019/7/3.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class MyNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
    }
    

	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if viewControllers.count > 0 {
			viewController.hidesBottomBarWhenPushed = true
		}
		super.pushViewController(viewController, animated: animated)
	}

}
