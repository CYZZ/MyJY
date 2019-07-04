//
//  MyAPN.swift
//  MyJY
//
//  Created by chiyz on 2019/7/4.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import UserNotifications

class MyAPN: NSObject {
	
	func addLocalNotice() -> Void {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			let content = UNMutableNotificationContent()
			// 标题
			content.title = "测试myjy标题"
			content.subtitle = "测试子标题"
			content.body = "测试的主题内容"
			content.badge = NSNumber(value: 1)
			// 多少秒后发送，可以将固定是的日期转化为时间
			let time  = Date(timeIntervalSinceNow: 10).timeIntervalSinceNow
//			let time = 10
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
			// repeats，是否重复，如果成功的话时间必须大于60s，要不会报错
			/*
			如果想要抽工夫可以使用
			// 每周一早上9:00上班
			weekday默认是周日开始
			
			var components = DateComponents()
			components.weekday = 2;
			components.hour = 8;
			let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
			*/
			
			// 设置每分钟提醒
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
			let date = formatter.date(from: "2019-07-04 09:00:00")!
			let components = Calendar.current.dateComponents([.minute,.second], from: date)
			let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
			
			
			let identifier  = "myjynoticeId"
//			let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
			let request = UNNotificationRequest(identifier: identifier, content: content, trigger: calendarTrigger)
			
			center.add(request) { (error) in
				print("添加通知成功")
			}
			
		} else {
			// Fallback on earlier versions
//			let notification = UILocalNotification()
//			// 发出推送的日期
//			notification.fireDate = Date(timeIntervalSinceNow: 10)
//			// 推送的内容
//			notification.alertBody = "你已经10秒没有动过我了"
//			// 可以添加特定的信息
//			let identifier = "0000123"
//			notification.userInfo = ["noticeId":identifier]
//			// 角标
//			notification.applicationIconBadgeNumber = 1
//			notification.repeatInterval = .weekOfYear // 每周循环
//
//			UIApplication.shared.scheduleLocalNotification(notification)
			//********************* 分割线 ****************
			let notification = UILocalNotification()
			// 发出推送的日期
//			notification.fireDate = Date(timeIntervalSinceNow: 10)
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
			let date = formatter.date(from: "2019-07-04 09:00:00")!
			notification.fireDate = date
			// 推送的内容
			notification.alertBody = "你已经收到准点报时"
			// 可以添加特定的信息
			let identifier = "0000123"
			notification.userInfo = ["noticeId":identifier]
			// 角标
			notification.applicationIconBadgeNumber = 1
			notification.repeatInterval = .hour // 每分钟循环
			notification.soundName = UILocalNotificationDefaultSoundName
			
			UIApplication.shared.scheduleLocalNotification(notification)
		}
	}
	
	func removeOneNotification(Identifier:String) -> Void {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.getPendingNotificationRequests { (requests) in
				for  request in requests {
					print("存在的id = \(request.identifier)")
				}
				print("将要移除的identifier = \(Identifier)")
			}
			center.removePendingNotificationRequests(withIdentifiers: [Identifier])
		} else {
			// Fallback on earlier versions
//			guard let array = UIApplication.shared.scheduledLocalNotifications else { return [UILocalNotification]() }
			var array = [UILocalNotification]()
			if let notifications = UIApplication.shared.scheduledLocalNotifications {
				array = notifications
			}
			for notification in array {
				let userInfo = notification
				let obj = userInfo.value(forKey: "noticeId") as! String
				if obj.elementsEqual(Identifier) {
					UIApplication.shared.cancelLocalNotification(notification)
				}
			}
		}
	}
	
	/// 移除所有通知
	func removeAllNotification() -> Void {
		
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.removeAllPendingNotificationRequests()
		} else {
			// Fallback on earlier versions
			UIApplication.shared.cancelAllLocalNotifications()
		}
	}
	/// 判断用户是否开启了通知
	func checkUserNotificationEnable() {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.getNotificationSettings { (settings) in
				if settings.notificationCenterSetting == .enabled {
					print("用户已经开启允许通知了")
				} else {
					print("用户没有开启通知权限")
					self.showAlerView()
				}
			}
		} else {
			// Fallback on earlier versions
			if UIApplication.shared.currentUserNotificationSettings?.types == [] {
				print("没有开启通知权限")
				self.showAlerView()
			} else {
				print("app已经开启了通知权限")
			}
		}
		
	}
	
	func showAlerView() -> Void {
		let alert = UIAlertController(title: "通知", message: "改APP未获取通知权限，q前往设置", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
			
		}))
		alert.addAction(UIAlertAction(title: "设置", style: .default, handler: { (action) in
			self.goToAppSystemSetting()
		}))
		UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
	}
	/// 前往设置
	func goToAppSystemSetting() -> Void {
		let application = UIApplication.shared
		let url = URL(string: UIApplication.openSettingsURLString)!
		
		if application.canOpenURL(url) {
			if #available(iOS 10.0, *) {
				application.open(url, options: [:], completionHandler: nil)
			} else {
				// Fallback on earlier versions
				application.openURL(url)
			}
		}
		
	}

}
