//
//  File.swift
//  
//
//  Created by Oliver Michalak on 13.11.21.
//

import UIKit
import StoreKit
import MessageUI
import SpriteKit

class LikeViewController: UIViewController, UINavigationControllerDelegate {
	var feedbackConfig: FeedbackConfig?
	var moduleConfig: FeedbackConfig.ContactModule?

	@IBOutlet weak var thanksView: SKView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// just for the fun of it...
		let modulePath = Bundle.module.bundleURL.lastPathComponent
		if let starNode = SKEmitterNode(fileNamed: "\(modulePath)/FeedbackStar"), let star = UIImage(systemName: "star.fill") {
			starNode.particleTexture = SKTexture(image: star)
			starNode.position = CGPoint(x: thanksView.bounds.midX, y: thanksView.bounds.maxY * 0.3)
			starNode.particlePositionRange = CGVector(dx: thanksView.bounds.width * 0.6, dy: 10)
			let scene = SKScene(size: thanksView.bounds.size)
			scene.backgroundColor = view.backgroundColor ?? .clear
			
			scene.scaleMode = .aspectFit;
			scene.addChild(starNode)
			thanksView.presentScene(scene)
		}
		else {
			thanksView.isHidden = true
		}
	}

	@IBAction func rate() {
		SKStoreReviewController.requestReview()
	}

	@IBAction func email() {
		if MFMailComposeViewController.canSendMail() {
			let emailer = MFMailComposeViewController()
			emailer.delegate = self
			emailer.setSubject("Email-Subject".localized)
			emailer.setMessageBody("Email-Text".localized, isHTML: false)
			present(emailer, animated: true)
		}
	}

	@IBAction func twitter() {
		let message = "Twitter-Text".localized.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

		if let url = URL(string: "twitterrific:///post?message=\(message)"),
				UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
		else if let url = URL(string: "tweetbot:///post?text=\(message)"),
						UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
		else if let url = URL(string: "twitter:///post?text=\(message)"),
						UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
		else if let url = URL(string: "http://twitter.com/home?status=\(message)"),
						UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
	}

	@IBAction func facebook() {
		let message = "Facebook-Text".localized.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

		if let url = URL(string: "https://m.facebook.com/sharer.php?u=\(message)"),
				UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
	}
}

extension LikeViewController: ModuleNaming {
	var name: ModuleName { .like }
	static var identifier: String { String(describing: self) }
}

extension LikeViewController: MFMailComposeViewControllerDelegate {
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true)
	}
}
