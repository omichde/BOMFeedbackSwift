//
//  ContactViewController.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

class ContactViewController: UIViewController {
	var moduleConfig: FeedbackConfig.ContactModule?
	var feedbackConfig: FeedbackConfig?

	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var dislikeButton: UIButton!
	
	@IBOutlet weak var containerView: UIView!

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		tabBarItem = UITabBarItem(title: "Contact".localized, image: UIImage(systemName: "bubble.left"), selectedImage: UIImage(systemName: "bubble.left.fill"))
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let likeViewController = segue.destination as? LikeViewController {
			likeViewController.moduleConfig = moduleConfig
			likeViewController.feedbackConfig = feedbackConfig
		}
		if let dislikeViewController = segue.destination as? DislikeViewController {
			dislikeViewController.moduleConfig = moduleConfig
			dislikeViewController.feedbackConfig = feedbackConfig
		}
	}
}

extension ContactViewController: ModuleNaming {
	var name: ModuleName { .contact }
	static var identifier: String { String(describing: self) }
}
