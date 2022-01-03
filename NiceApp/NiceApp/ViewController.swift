//
//  ViewController.swift
//  NiceApp
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit
import Feedback

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func openFeedback() {
		let config = FeedbackConfig(APPId: "12345678",
																ITMSURL: "https://itunes.apple.com/de/app/id12345678?mt=8",
																navigationBarColor: "#ff0000",
																modules: [.contact(FeedbackConfig.ContactModule(email: "info@omich.de", services: [.store, .email, .twitter, .facebook], faqFile: "FeedbackFAQ.plist")),
																					.apps("https://getallniceapps.com"),
																					.about("FeedbackAbout.md"),
																					.modules(["Package1.rtf", "Package2.html", "Package3.pdf"])])
		let feedbackViewController = FeedbackController(config)
		present(feedbackViewController, animated: true)
	}
}

