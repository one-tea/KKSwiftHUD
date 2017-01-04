//
//  ViewController.swift
//  KKSwiftHUD
//
//  Created by Kevin on 2017/1/4.
//  Copyright © 2017年 zhangkk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let TYPE_STATE = true
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		#if TYPE_STATE
			//		KKSwiftProgressHUD.showInController(controller: self, text: "加载成功")
			KKSwiftProgressHUD.showInController(controller: self, text: "加载成功", type: .notificationTypeSuccess)
		#else
			KKSwiftProgressHUD.showInController(controller: self, text: "加载失败", type: .notificationTypeWarring)
		#endif
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

