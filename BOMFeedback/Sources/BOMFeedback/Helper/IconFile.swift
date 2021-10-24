//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

enum IconFont: String {
	case pen = "\uf000"
	case search = "\uf001"
	case plus = "\uf002"
	case minus = "\uf003"
	case cross = "\uf004"
	case arrowRight = "\uf005"
	case arrowLeft = "\uf006"
	case arrowRightGrowing = "\uf007"
	case heartFilled = "\uf008"
	case heart = "\uf009"
	case starFilled = "\uf00b"
	case star = "\uf00c"
	case headFilled = "\uf00d"
	case head = "\uf00e"
	case mailFilled = "\uf00f"
	case mail = "\uf010"
	case factoryFilled = "\uf012"
	case factory = "\uf013"
	case modulesFilled = "\uf017"
	case modules = "\uf018"
	case bubbleFilled = "\uf019"
	case bubble = "\uf01a"
	case clipFilled = "\uf01b"
	case clip = "\uf01c"
	case bookFilled = "\uf01d"
	case book = "\uf01e"
	case smilyProblem = "\uf00a"
	case puzzleFilled = "\uf011"
	case gear = "\uf01f"
	case twitter = "\uf014"
	case facebook = "\uf015"
	case share = "\uf016"

	static let barButtonIconFontSize: CGFloat = 22
	static let feedbackDefaultFontSize: CGFloat = 15
}

extension UIFont {
	static func iconFont(size: CGFloat) -> UIFont? {
		if let font = UIFont(name: "Feedback", size: size) {
			return font
		}
		if let fontURL = Bundle.main.url(forResource: "Feedback-Regular", withExtension: "otf") {
			var error: CFError
			CTFontManagerRegisterFontsForURL(CFURL(fontURL), CTFontManagerScope.process, &error)
		}
		return UIFont(name: "Feedback", size: size)
	}

	static func iconFont() -> UIFont? {
		iconFont(size: IconFont.feedbackDefaultFontSize)
	}
}

extension UIButton {
	static func icon(token: IconFont) -> UIButton {
		return [self iconButton:token target:nil action:nil];
	}

	static func iconButton(token: IconFont, target:Any, action:Selector) -> UIButton {
		iconButton(token: token, fontSize: IconFont.feedbackDefaultFontSize, target: target, action: action)
	}

	static func iconButton(token: IconFont, fontSize:CGFloat, target:Any, action:Selector) -> UIButton {
		let button = UIButton(type: .system)
		button.setIcon(token: token, fontSize: fontSize)
		
		if target && action {
			button.addTarget(target, action: action, for: .touchUpInside)
		}
		return button;
	}

	func setIcon(token: IconFont) {
		var font: UIFont?
		let range = NSMakeRange(0, 1)
		if let title = currentAttributedTitle {
			let attributes = title.attributes(at: 0, effectiveRange: &range)
			font = attributes[NSFontAttributeName]
		}
		setIcon(token: token, fontSize: (font ? font?.pointSize ?? IconFont.feedbackDefaultFontSize))
	}

	func setIcon(token: IconFont, fontSize:CGFloat) {
		titleLabel?.font = UIFont.iconFont(size: fontSize)
		setTitle(token, for: .normal)
		sizeToFit()
	}
	
//	- (void) feedbackPrependTextWithIcon:(NSString*)token color:(UIColor*)color {
//		CGFloat fontSize = self.titleLabel.font.pointSize;
//		NSAttributedString *buttonText = [[NSAttributedString alloc] initWithString:self.currentTitle attributes:@{NSFontAttributeName: self.titleLabel.font, NSForegroundColorAttributeName: self.currentTitleColor}];
//
//		NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:token attributes:@{NSFontAttributeName: [UIFont feedbackIconFontWithSize:fontSize], NSForegroundColorAttributeName:color}];
//		[text appendAttributedString:[[NSAttributedString alloc] initWithString:@"  " attributes:@{}]];
//		[text appendAttributedString:buttonText];
//		[self setAttributedTitle:text forState:UIControlStateNormal];
//	}

}

extension UIBarButtonItem {
	static func iconBarButtonItem(token: IconFont, target:Any, action:Selector) -> UIBarButtonItem {
		let button = UIButton.iconButton(token: token, fontSize: IconFont.barButtonIconFontSize, target: target, action: action)
		return UIBarButtonItem(customView: button)
	}

	static func iconBarButtonItems(token: IconFont, target:Any, action:Selector) -> [UIBarButtonItem] {
		[UIBarButtonItem.spaceBarButtonItem(),
		 UIBarButtonItem.iconBarButtonItem(token: token, target: target, action: action)]
	}

	func setIcon(token: IconFont) {
		setIcon(token: token, forState: .normal)
	}
	
	func setIcon(token: IconFont, forState:UIControlState) {
		guard let button = customView else { return }
		button.setIcon(token: token, fontSize: IconFont.feedbackDefaultFontSize)
	}

	static func spaceBarButtonItem(width: CGFloat) -> UIBarButtonItem {
		let spaceFix = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
		spaceFix.width = -width
		return spaceFix
	}

	static func spaceBarButtonItem() -> UIBarButtonItem {
		spaceBarButtonItem(width: -12)
	}
}

extension UIImage {
	
	static func iconTabBarImage(token: IconFont) -> UIImage {
		iconImage(token: token, fontSize: 27, fontColor: .gray, boxSize: CGSize(width: 30, height: 30))
	}

	static func iconImage(token: IconFont, fontSize:CGFloat, fontColor:UIColor, boxSize:CGSize) -> UIImage {
		let attributedToken = NSAttributedString(string: token.rawValue,
																						 attributes: [NSAttributedString.Key.font: UIFont.iconFont(size: fontSize),
																													NSAttributedString.Key.foregroundColor: fontColor])
		let size = attributedToken.size
		UIGraphicsBeginImageContextWithOptions(boxSize, false, 0)
		let tokenRect = CGRect((boxSize.width - size.width)/2,
													 (boxSize.height - size.height)/2,
													 size.width,
													 size.height)
		attributedToken.draw(in: tokenRect)
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
	
		return result
	}
}
