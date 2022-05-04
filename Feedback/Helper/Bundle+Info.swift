//
//  File.swift
//  
//
//  Created by Oliver Michalak on 30.12.21.
//

import Foundation
import UIKit

extension Bundle {

	var name: String {
		infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
	}
	
	var version: String {
		guard let info = infoDictionary else { return "" }
		return info["CFBundleShortVersionString"] as? String ?? ""
	}
	
	var build: String {
		guard let info = infoDictionary else { return "" }
		return info["CFBundleVersion"] as? String ?? ""
	}

	
	var icon: UIImage? {
		if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
			 let primary = icons["CFBundlePrimaryIcon"] as? [String: Any],
			 let files = primary["CFBundleIconFiles"] as? [String],
			 let icon = files.last {
			return UIImage(named: icon)
		}

		return nil
	}

}
