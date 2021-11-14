//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import UIKit
import WebKit

class AppsViewController: UIViewController {
	var urlString: String?
	var feedbackConfig: FeedbackConfig?

	@IBOutlet weak var webView: WKWebView!

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		title = "APPs".localized
		tabBarItem = UITabBarItem(title: "APPs".localized, image: UIImage(systemName: "puzzlepiece"), selectedImage: UIImage(systemName: "puzzlepiece.fill"))
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		if let urlString = urlString, var comp = URLComponents(string: urlString) {
			comp.queryItems = [URLQueryItem(name: "locale", value: Locale.current.identifier),
												 URLQueryItem(name: "src", value: Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "")]
			if let url = comp.url {
				let request = URLRequest(url: url)
				webView.load(request)
			}
		}
	}
}

extension AppsViewController: ModuleNaming {
	var name: ModuleName { .apps }
	static var identifier: String { String(describing: self) }
}
