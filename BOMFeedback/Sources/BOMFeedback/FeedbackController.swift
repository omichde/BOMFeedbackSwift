//
//  FeedbackController.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

class FeedbackController: UITabBarController, /* UITabBarDelegate,*/ UITabBarControllerDelegate {

	let config: FeedbackConfig

	public init(_ config: FeedbackConfig) {
		self.config = config
		super.init()
		setup()
	}

	convenience public init?(_ configURL: URL) {
		guard let data = try? Data(contentsOf: configURL) else { return nil }
		
		if configURL.path.hasSuffix("json") {
			guard let config = try? JSONDecoder().decode(FeedbackConfig.self, from: data)
			else { return nil }
			self.init(config)
		}

		if configURL.path.hasSuffix("plist") {
			guard let config = try? PropertyListDecoder().decode(FeedbackConfig.self, from: data)
			else { return nil }
			self.init(config)
		}
		return nil
	}
	
	func setup() {
		let storyboard = UIStoryboard(name: "Feedback", bundle: nil)
		var viewControllers = [UIViewController]()
		for module in config.modules {
			var viewController: UIViewController?
			switch module {
			case let .contact(contact):
				let contactViewController = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
				contactViewController.moduleConfig = contact
				contactViewController.feedbackConfig = config
				viewController = contactViewController
			case let .apps(app):
				()
			case let .about(about):
				()
			case let .modules(modules):
				()
			}
			guard let viewController = viewController else { continue }
			let navController = UINavigationController(rootViewController: viewController)
			if let navColor = config.navigationBarColor {
				navController.navigationBar.tintColor = UIColor(navColor)
				navController.navigationBar.isTranslucent = false
			}
			if view.isDarkMode {
				navController.navigationBar.barStyle = .black
				navController.view.backgroundColor = .black
			}
			else {
				navController.view.backgroundColor = .white
			}
			viewControllers.append(navController)
		}
		self.viewControllers = viewControllers
		self.selectedIndex = 0
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	///	Dismisses the Feedback Controller altogether
	public func dismiss() {
		dismiss(animated: true, completion: nil)
	}

	/// Presents a specific module and pops back to its start view controller.
	/// - parameters name The same name given in the configuration file.
	public func present(name: ModuleName) {
		guard let list = viewControllers,
					let idx = list.firstIndex(where: { vc in
			guard let navVC = vc as? UINavigationController,
						let contentVC = navVC.viewControllers.first,
						let contentVC = contentVC as? ModuleNaming else { return false }
			return contentVC.name == name
		})
		else { return }
		
		let navVC = list[idx] as! UINavigationController
		navVC.popToRootViewController(animated: false)
		selectedViewController = navVC
	}
}
