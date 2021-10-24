//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

extension UIColor {
	convenience init?(_ text: String) {
		var code = text
		if code.hasPrefix("#") {
			let start = code.index(code.startIndex, offsetBy: 1)
			code = String(code[start...])
			guard code.count == 6 else { return nil }

			let scanner = Scanner(string: code)
			var hexNumber: UInt64 = 0
			
			if scanner.scanHexInt64(&hexNumber) {
				let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
				let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
				let b = CGFloat(hexNumber & 0x0000ff) / 255
				
				self.init(red: r, green: g, blue: b, alpha: 1)
			}
		}
		else {
			let list = code.components(separatedBy: ",")
			guard list.count == 3 else { return nil }
			var vals = [CGFloat]()
			for val in list {
				let scanner = Scanner(string: val)
				var number: Float = 0
				if scanner.scanFloat(&number) {
					vals.append(CGFloat(number))
				}
				guard vals.count == 3 else { return nil }
				self.init(red: vals[0], green: vals[1], blue: vals[2], alpha: 1)
			}
		}
		return nil
	}
}
