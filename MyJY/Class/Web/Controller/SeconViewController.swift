//
//  SeconViewController.swift
//  MyJY
//
//  Created by chiyz on 2019/7/3.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class SeconViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textField: UITextField!
	
	private let defaultsKey = "defaultKey"
	var urlArr = [String]()
	
	var callback:(_ url:String) -> () = { _ in
		print("默认的回调")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(rightItemClick))
		self.readData()
	}
	
	/// 从沙盒读取内存数据
	func readData() -> Void {
		let defaults = UserDefaults()
		
		if let data = defaults.value(forKey: defaultsKey) {
			urlArr = data as! [String]
		}
		tableView.reloadData()
		print("读取到的url数组 =\(urlArr)")
		
	}

	@objc func rightItemClick(){
		print("保存数据")
		if let text = textField.text {
			if text.count > 0 {
				urlArr.insert(text, at: 0)
				UserDefaults().setValue(urlArr, forKey: defaultsKey)
				tableView.reloadData()
				print("保存的数据 = \(text)")
			}
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		UIApplication.shared.keyWindow?.endEditing(true)
	}
}

extension SeconViewController:UITableViewDataSource,UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return urlArr.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = urlArr[indexPath.row]
		cell.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
		return cell;
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// 点击了某行
		tableView.deselectRow(at: indexPath, animated: true)
		self.callback(urlArr[indexPath.row])
		self.navigationController?.popViewController(animated: true)
	}
	
	// 侧滑功能
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .delete
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		// 点击删除确认按钮
		urlArr.remove(at: indexPath.row)
		UserDefaults().setValue(urlArr, forKey: defaultsKey)
		tableView.deleteRows(at: [indexPath], with: .fade)
	}
	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		UIApplication.shared.keyWindow?.endEditing(true)
	}
}
