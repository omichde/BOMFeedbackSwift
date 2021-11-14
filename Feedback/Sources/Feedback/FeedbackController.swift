//
//  FeedbackController.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

public class FeedbackController: UITabBarController, /* UITabBarDelegate,*/ UITabBarControllerDelegate {

	let config: FeedbackConfig

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	public init(_ config: FeedbackConfig) {
		self.config = config
		super.init(nibName: "Feedback", bundle: Bundle.module)
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
		var list = [UIViewController]()
		for module in config.modules {
			var viewController: UIViewController?
			let storyboard = UIStoryboard(name: "Feedback", bundle: Bundle.module)
			switch module {
			case let .contact(contact):
				if let vc = storyboard.instantiateViewController(withIdentifier: ContactViewController.identifier) as? ContactViewController {
					vc.moduleConfig = contact
					vc.feedbackConfig = config
					viewController = vc
				}
			case let .apps(url):
				if let vc = storyboard.instantiateViewController(withIdentifier: AppsViewController.identifier) as? AppsViewController {
					vc.urlString = url
					vc.feedbackConfig = config
					viewController = vc
				}
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
			viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))
			list.append(navController)
		}
		self.viewControllers = list
		self.selectedIndex = 0
		self.modalPresentationStyle = .automatic
	}
	
	///	Dismisses the Feedback Controller altogether
	@objc func close() {
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
