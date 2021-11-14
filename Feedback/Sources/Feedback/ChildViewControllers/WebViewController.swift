//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, ModuleNaming {
	static var identifier: String { String(describing: self) }
	var name: ModuleName!
	var url: URL!

	@IBOutlet weak var webView: WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		if url.isFileURL {
			webView.loadFileURL(url, allowingReadAccessTo: Bundle.main.bundleURL)
		}
		else {
			webView.load(URLRequest(url: url))
		}
	}
}
