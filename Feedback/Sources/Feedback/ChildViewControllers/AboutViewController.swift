//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
	var aboutString: String?
	var feedbackConfig: FeedbackConfig?

	@IBOutlet weak var webView: WKWebView!

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		title = "About".localized
		tabBarItem = UITabBarItem(title: "About".localized, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		if let about = aboutString {
			let file = URL(fileURLWithPath: about, relativeTo: Bundle.main.bundleURL)
			webView.loadFileURL(file, allowingReadAccessTo: Bundle.main.bundleURL)
		}
	}
}

extension AboutViewController: ModuleNaming {
	var name: ModuleName { .about }
	static var identifier: String { String(describing: self) }
}
