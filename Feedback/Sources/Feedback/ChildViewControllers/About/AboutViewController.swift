//
//  File.swift
//  
//
//  Created by Oliver Michalak on 30.12.21.
//

import UIKit

class AboutViewController: UIViewController, ModuleNaming {
	static var identifier: String { String(describing: self) }
	var name: ModuleName!

	let model: AboutViewModel
	
	@IBOutlet var container: UIView!

	init?(coder: NSCoder, about: String) {
		model = AboutViewModel(icon: Bundle.main.icon ?? UIImage(),
													 name: Bundle.main.name,
													 version: Bundle.main.version,
													 build: Bundle.main.build,
													 text: about)
		super.init(coder: coder)

		title = "About".localized
		tabBarItem = UITabBarItem(title: "About".localized, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
		name = .about
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		embed(AboutView(model: model), container: container)
	}
}
