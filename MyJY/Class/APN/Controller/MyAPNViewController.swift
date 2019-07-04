//
//  MyAPNViewController.swift
//  MyJY
//
//  Created by chiyz on 2019/7/4.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class MyAPNViewController: UIViewController {
	
	lazy var apn: MyAPN = {
		let apn = MyAPN()
		return apn
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func openNotice(_ sender: UIButton) {
		apn.addLocalNotice()
	}
	
	@IBAction func closeNotice(_ sender: UIButton) {
		apn.removeAllNotification()
	}
	@IBAction func checkNotice(_ sender: UIButton) {
		apn.checkUserNotificationEnable()
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
