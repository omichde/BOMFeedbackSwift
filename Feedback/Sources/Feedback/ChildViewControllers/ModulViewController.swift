//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import UIKit
import WebKit

class ModulViewController: UIViewController {
	var moduleURL: URL?

	@IBOutlet weak var webView: WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		if let url = moduleURL {
			title = url.lastPathComponent.removeSuffix()
			webView.loadFileURL(url, allowingReadAccessTo: Bundle.main.bundleURL)
		}
	}
}

extension ModulViewController: ModuleNaming {
	var name: ModuleName { .module }
	static var identifier: String { String(describing: self) }
}
