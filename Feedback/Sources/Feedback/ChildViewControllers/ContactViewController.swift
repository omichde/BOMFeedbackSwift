//
//  ContactViewController.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

class ContactViewController: UIViewController {
	var feedbackConfig: FeedbackConfig?
	var moduleConfig: FeedbackConfig.ContactModule?

	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var dislikeButton: UIButton!
	
	@IBOutlet weak var containerView: UIView!

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		title = "Contact".localized
		tabBarItem = UITabBarItem(title: "Contact".localized, image: UIImage(systemName: "bubble.left"), selectedImage: UIImage(systemName: "bubble.left.fill"))
	}
}

extension ContactViewController: ModuleNaming {
	var name: ModuleName { .contact }
	static var identifier: String { String(describing: self) }
}
