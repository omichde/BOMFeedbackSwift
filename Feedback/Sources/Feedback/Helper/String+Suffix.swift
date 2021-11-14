//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import Foundation

extension String {
	func removeSuffix() -> String {
		guard let idx = lastIndex(of: ".") else { return self }
		guard idx != self.startIndex else { return "" }
		return String(self[self.startIndex...self.index(before: idx)])
	}
}
