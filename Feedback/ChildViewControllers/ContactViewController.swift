//
//  ContactViewController.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

class ContactViewController: UIViewController, ModuleNaming {

	static var identifier: String { String(describing: self) }
	var name: ModuleName!
	var moduleConfig: FeedbackConfig.ContactModule?
	var feedbackConfig: FeedbackConfig?

	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var dislikeButton: UIButton!
	
	@IBOutlet weak var containerView: UIView!

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		title = "Contact".localized
		tabBarItem = UITabBarItem(title: "Contact".localized, image: UIImage(systemName: "bubble.left"), selectedImage: UIImage(systemName: "bubble.left.fill"))
		name = .contact
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let submodule = moduleConfig?.submodule,
			 let clazz = NSClassFromString("\(Bundle.main.name).\(submodule)") as? UIViewController.Type {
			let viewController = clazz.init()
			embedChild(viewController, container: containerView)
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let likeViewController = segue.destination as? LikeViewController {
			likeViewController.moduleConfig = moduleConfig
		}
		if let dislikeViewController = segue.destination as? DislikeViewController {
			dislikeViewController.moduleConfig = moduleConfig
			dislikeViewController.feedbackConfig = feedbackConfig
		}
	}

}
