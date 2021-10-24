//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

extension UIView {
	var isDarkMode: Bool {
		if #available(iOS 13.0, *) {
			return traitCollection.userInterfaceStyle == .dark
		}
		else {
			return false
		}
	}
}
