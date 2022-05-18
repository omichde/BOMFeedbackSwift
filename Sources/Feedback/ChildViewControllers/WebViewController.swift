//
//  File.swift
//  
//
//  Created by Oliver Michalak on 18.05.22.
//

import UIKit
import WebKit


class WebViewController: UIViewController, ModuleNaming {

	static var identifier: String { String(describing: self) }
	@IBOutlet weak var webView: WKWebView!
	var name: ModuleName!
	var url: URL?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let url = url {
			webView.load(URLRequest(url: url))
		}
	}

}
