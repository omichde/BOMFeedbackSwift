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
		let navAppearance = UINavigationBarAppearance()
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
			case let .apps(urlString):
				if let vc = storyboard.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController {
					vc.title = "APPs".localized
					vc.tabBarItem = UITabBarItem(title: "APPs".localized, image: UIImage(systemName: "app.gift"), selectedImage: UIImage(systemName: "app.gift.fill"))
					if var comp = URLComponents(string: urlString) {
						comp.queryItems = [URLQueryItem(name: "locale", value: Locale.current.identifier),
															 URLQueryItem(name: "src", value: Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "")]
						if let url = comp.url {
							vc.url = url
							vc.name = .apps
							viewController = vc
						}
					}
				}
			case let .about(about):
				if let vc = storyboard.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController {
					vc.title = "About".localized
					vc.tabBarItem = UITabBarItem(title: "About".localized, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
					vc.url = URL(fileURLWithPath: about, relativeTo: Bundle.main.bundleURL)
					vc.name = .about
					viewController = vc
				}
			case let .modules(modules):
				if let vc = storyboard.instantiateViewController(withIdentifier: ModulesViewController.identifier) as? ModulesViewController {
					vc.modules = modules
					vc.feedbackConfig = config
					viewController = vc
				}
			}

			guard let viewController = viewController else { continue }
			let navController = UINavigationController(rootViewController: viewController)
			navController.navigationBar.standardAppearance = navAppearance
			navController.navigationBar.scrollEdgeAppearance = navAppearance
			if let navColor = config.navigationBarColor {
				navController.navigationBar.barTintColor = UIColor(navColor)
				navController.navigationBar.isTranslucent = false
			}
			viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))
			list.append(navController)
		}
		self.viewControllers = list
		self.selectedIndex = 0
		self.modalPresentationStyle = .automatic
		let tabAppearance = UITabBarAppearance()
		self.tabBar.standardAppearance = tabAppearance
		if #available(iOS 15.0, *) {
			self.tabBar.scrollEdgeAppearance = tabAppearance
		}
	}
	
	///	Dismisses the Feedback Controller altogether
	@objc func close() {
		dismiss(animated: true, completion: nil)
	}

	/// Presents a specific module and pops back to its start view controller.
	/// - parameters name The same name given in the configuration file.
	public func present(name: ModuleName) {
		guard let list = viewControllers,
					let navVC = list.first(where: { vc in
			guard let navVC = vc as? UINavigationController,
						let contentVC = navVC.viewControllers.first,
						let moduleVC = contentVC as? ModuleNaming else { return false }
			return moduleVC.name == name
		}) as? UINavigationController
		else { return }
		
		navVC.popToRootViewController(animated: false)
		selectedViewController = navVC
	}
}
