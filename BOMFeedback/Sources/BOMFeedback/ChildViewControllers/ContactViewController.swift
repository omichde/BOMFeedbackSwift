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
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
//		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"Contact") image:[[UIImage feedbackIconTabBarImage:IFBubble] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFBubbleFilled]];
	}
	
}

extension ContactViewController: ModuleNaming {
	var name: ModuleName {
		.contact
	}
}
