//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import UIKit

enum IconFont: String {
	case pen = "\u{f000}"
	case search = "\u{f001}"
	case plus = "\u{f002}"
	case minus = "\u{f003}"
	case cross = "\u{f004}"
	case arrowRight = "\u{f005}"
	case arrowLeft = "\u{f006}"
	case arrowRightGrowing = "\u{f007}"
	case heartFilled = "\u{f008}"
	case heart = "\u{f009}"
	case starFilled = "\u{f00b}"
	case star = "\u{f00c}"
	case headFilled = "\u{f00d}"
	case head = "\u{f00e}"
	case mailFilled = "\u{f00f}"
	case mail = "\u{f010}"
	case factoryFilled = "\u{f012}"
	case factory = "\u{f013}"
	case modulesFilled = "\u{f017}"
	case modules = "\u{f018}"
	case bubbleFilled = "\u{f019}"
	case bubble = "\u{f01a}"
	case clipFilled = "\u{f01b}"
	case clip = "\u{f01c}"
	case bookFilled = "\u{f01d}"
	case book = "\u{f01e}"
	case smilyProblem = "\u{f00a}"
	case puzzleFilled = "\u{f011}"
	case gear = "\u{f01f}"
	case twitter = "\u{f014}"
	case facebook = "\u{f015}"
	case share = "\u{f016}"

	static let barButtonIconFontSize: CGFloat = 22
	static let feedbackDefaultFontSize: CGFloat = 15
}

extension UIFont {
	static func iconFont(size: CGFloat) -> UIFont? {
		if let font = UIFont(name: "Feedback", size: size) {
			return font
		}
		if let fontURL = Bundle.main.url(forResource: "Feedback-Regular", withExtension: "otf") {
			CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
		}
		return UIFont(name: "Feedback", size: size)
	}

	static func iconFont() -> UIFont? {
		iconFont(size: IconFont.feedbackDefaultFontSize)
	}
}

extension UIButton {
	static func iconButton(token: IconFont) -> UIButton {
		iconButton(token: token, target: nil, action: nil)
	}

	static func iconButton(token: IconFont, target:Any?, action:Selector?) -> UIButton {
		iconButton(token: token, fontSize: IconFont.feedbackDefaultFontSize, target: target, action: action)
	}

	static func iconButton(token: IconFont, fontSize:CGFloat, target:Any?, action:Selector?) -> UIButton {
		let button = UIButton(type: .system)
		button.setIcon(token: token, fontSize: fontSize)

		if let action = action {
			button.addTarget(target, action: action, for: .touchUpInside)
		}
		return button
	}

	func setIcon(token: IconFont) {
		var font: UIFont?
		var range = NSMakeRange(0, 1)
		if let title = currentAttributedTitle {
			let attributes = title.attributes(at: 0, effectiveRange: &range)
			font = attributes[NSAttributedString.Key.font] as? UIFont
		}
		setIcon(token: token, fontSize: (font?.pointSize ?? IconFont.feedbackDefaultFontSize))
	}

	func setIcon(token: IconFont, fontSize:CGFloat) {
		titleLabel?.font = UIFont.iconFont(size: fontSize)
		setTitle(token.rawValue, for: .normal)
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
	
	func setIcon(token: IconFont, forState: UIControl.State) {
		guard let button = customView as? UIButton else { return }
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
	
	static func iconTabBarImage(token: IconFont) -> UIImage? {
		iconImage(token: token, fontSize: 27, fontColor: .gray, boxSize: CGSize(width: 30, height: 30))
	}

	static func iconImage(token: IconFont, fontSize:CGFloat, fontColor:UIColor, boxSize:CGSize) -> UIImage? {
		let attributedToken = NSAttributedString(string: token.rawValue,
																						 attributes: [NSAttributedString.Key.font: UIFont.iconFont(size: fontSize)!,
																													NSAttributedString.Key.foregroundColor: fontColor])
		let size = attributedToken.size()
		UIGraphicsBeginImageContextWithOptions(boxSize, false, 0)
		let tokenRect = CGRect(x: (boxSize.width - size.width)/2,
													 y: (boxSize.height - size.height)/2,
													 width: size.width,
													 height: size.height)
		attributedToken.draw(in: tokenRect)
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
	
		return result
	}
}
