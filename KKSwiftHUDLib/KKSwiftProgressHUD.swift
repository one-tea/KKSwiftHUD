//
//  KKSwiftProgressHUD.swift
//  Simple
//
//  Created by Kevin on 16/12/15.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

let DEFAULT_EDGE:CGFloat = 24.0
let DEFAULT_SPACE_IMAGE_TEXT:CGFloat = 5.0
let DEFAULT_RATE_WINDTH:CGFloat = 0.7
let DEFUALT_DURATION:CGFloat = 2.0
let DEFAULT_ANIMAATOM_DURATION:CGFloat = 1
let DEFAULT_HEIGHT:CGFloat = 40.0

class KKSwiftProgressHUD: UIView {
	
	enum NotificationType {
		case notificationTypeWarring
		case notificationTypeSuccess
		
	}
	
	/* open */
	public var  duration :TimeInterval!
	public var  type:NotificationType = .notificationTypeSuccess {
		
		willSet(newType){
			switch newType {
			case .notificationTypeSuccess:
				imageView.image = UIImage(named: "notification_success")
			case .notificationTypeWarring:
				imageView.image = UIImage(named: "notification_warring")
			}
		}
		
	}
	
	/* private */
	private var controllerView: UIViewController!
	private var text: String!
	private var imageView: UIImageView!
	private var textLabel: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.layer.backgroundColor = UIColor.gray.cgColor
		self.layer.cornerRadius = 5.0
		self.layer.opacity = 1
		
		imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: DEFAULT_EDGE, height: DEFAULT_EDGE))
		textLabel = UILabel(frame: frame)
		textLabel.textColor = UIColor.white
		textLabel.backgroundColor = UIColor.clear
		duration = Double(DEFAULT_ANIMAATOM_DURATION)

		
		addSubview(imageView)
		addSubview(textLabel)
		
	}
	
	/* convenienceinit */
	convenience init(controllerView:UIViewController! ,text:String!) {
		
		let frame = CGRect(x: 0, y: -DEFAULT_HEIGHT, width: controllerView.view.bounds.width * DEFAULT_RATE_WINDTH, height: DEFAULT_HEIGHT)
		self.init(frame: frame)
		
		
		textLabel.text = text
		self.controllerView = controllerView
		
		textLabel.sizeToFit()
		
		let size = self.textLabel.bounds.size
		
		if size.width > (self.bounds.size.width - DEFAULT_EDGE - 2*DEFAULT_SPACE_IMAGE_TEXT) {
			self.imageView.center = CGPoint(x: DEFAULT_EDGE/2+DEFAULT_SPACE_IMAGE_TEXT, y: DEFAULT_HEIGHT/2+DEFAULT_SPACE_IMAGE_TEXT/2)
			
		}else{
			let edge_left =  (self.bounds.size.width-size.width-DEFAULT_SPACE_IMAGE_TEXT*2-DEFAULT_EDGE)/2
			self.imageView.center = CGPoint(x: edge_left+DEFAULT_SPACE_IMAGE_TEXT+DEFAULT_EDGE/2, y:DEFAULT_HEIGHT/2+DEFAULT_SPACE_IMAGE_TEXT/2
			)
		}
		self.textLabel.center = CGPoint(x: self.imageView.frame.maxX+DEFAULT_SPACE_IMAGE_TEXT+size.width/2, y: self.imageView.center.y)
		
		self.center = CGPoint(x: controllerView.view.bounds.size.width/2, y: self.center.y)
	}
	
	func showWithAnimation(isAnimation: Bool) -> Void {
		
		var  frame  = self.frame
		print(self.controllerView.parent ?? "nopNav" )
		print(self.controllerView.navigationController?.navigationController?.navigationBar.isHidden ?? "nohidden")
		if  self.controllerView.parent?.isKind(of: UINavigationController.classForCoder()) == true &&  self.controllerView.navigationController?.navigationBar.isHidden == false {
			frame.origin.y = 64 - DEFAULT_SPACE_IMAGE_TEXT
		}else{
			frame.origin.y  = -DEFAULT_SPACE_IMAGE_TEXT
		}
		
		if isAnimation {
			UIView.animate(withDuration: TimeInterval(duration), animations: {
				self.frame = frame
			}, completion: { (finish: Bool) in
				self.showHandle()
			})
		}else{
			self.frame = frame
			self.showHandle()
		}
	}
	
	func showHandle() -> Void {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(duration)) , execute: {
			DispatchQueue.main.async {
				self.dismissAnimation(isAnimation: true)
			}
		})
	}
	
	func dismissAnimation(isAnimation:Bool) {
		
		var  frame = self.frame
		frame.origin.y = -DEFAULT_HEIGHT
		
		if isAnimation  {
			UIView.animate(withDuration: TimeInterval(duration), animations: {
				self.frame = frame
			}, completion: { (finish: Bool) in
				self.removeFromSuperview()
			})
		}else{
			self.removeFromSuperview()
		}
		
	}
	
	/* class */
	class func showInController(controller:UIViewController, text: String){
		showInController(controller: controller, text: text, type: .notificationTypeSuccess)
	}
	
	class func showInController(controller: UIViewController ,text:String, type: NotificationType){
		let  kkSwiftHud = KKSwiftProgressHUD(controllerView: controller, text: text)
		controller.view.addSubview(kkSwiftHud)
		kkSwiftHud.type = type
		kkSwiftHud.showWithAnimation(isAnimation: true)
	}
	
	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/
	
}

