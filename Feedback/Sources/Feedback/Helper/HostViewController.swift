//
//  MarkdownViewController.swift
//  
//
//  Created by Oliver Michalak on 08.01.22.
//

import UIKit
import SwiftUI

class HostViewController: UIViewController, ModuleNaming {
	static var identifier: String { String(describing: self) }
	var name: ModuleName!
	var contentView: AnyView?
	
	@IBOutlet var container: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()

		if let contentView = contentView {
			embed(contentView, container: container)
		}
	}
}
