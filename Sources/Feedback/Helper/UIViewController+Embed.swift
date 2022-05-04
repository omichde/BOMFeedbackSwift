//
//  File.swift
//  
//
//  Created by Oliver Michalak on 02.01.22.
//

import SwiftUI

extension UIViewController {

	func embed<Content>(_ view: Content, container: UIView? = nil) where Content: View {
		let vc = UIHostingController(rootView: view)
		embedChild(vc, container: container ?? self.view)
	}

	func embedChild(_ viewController: UIViewController, container: UIView) {
		container.translatesAutoresizingMaskIntoConstraints = false
		viewController.view.translatesAutoresizingMaskIntoConstraints = false
		
		viewController.view.frame = container.bounds
		addChild(viewController)
		container.addSubview(viewController.view)
		
		NSLayoutConstraint.activate([
			container.topAnchor.constraint(equalTo: viewController.view.topAnchor),
			container.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
			container.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
			container.leftAnchor.constraint(equalTo: viewController.view.leftAnchor)
		])
		
		viewController.didMove(toParent: self)
	}
	
	func liftChild(_ container: UIView) {
		if let childViewController = childViewControllerOf(container) {
			childViewController.willMove(toParent: nil)
			childViewController.view.removeFromSuperview()
			childViewController.removeFromParent()
		}
	}
	
	private func childViewControllerOf(_ view: UIView) -> UIViewController? {
		return children.filter({ $0.view.superview == view }).first
	}

}

