//
//  SubViewController.swift
//  NiceApp
//
//  Created by Oliver Michalak on 04.05.22.
//

import UIKit
import Feedback


class SubViewController: UIViewController {

	@IBAction func hooray() {
		guard let feedbackController = tabBarController as? FeedbackController else { return }
		
		feedbackController.present(name: .apps)
	}

	@IBAction func close() {
		guard let feedbackController = tabBarController as? FeedbackController else { return }
		
		feedbackController.close()
	}

}
