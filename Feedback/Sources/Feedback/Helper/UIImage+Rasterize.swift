//
//  File.swift
//  
//
//  Created by Oliver Michalak on 29.12.21.
//

import UIKit

extension UIImage {
	func rasterize() -> UIImage? {
		let size = CGSize(width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
		draw(at: CGPoint(x: 0, y: 0))
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return result
	}
}
