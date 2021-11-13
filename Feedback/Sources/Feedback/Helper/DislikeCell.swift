//
//  File.swift
//  
//
//  Created by Oliver Michalak on 13.11.21.
//

import UIKit

class DislikeCell: UITableViewCell {
	static var identifier: String {
		String(describing: self)
	}
	
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var answerLabel: UILabel!

	var item: FAQItem? {
		didSet {
			guard let item = item else { return }
			questionLabel.text = item.question
			answerLabel.text = item.answer
			answerLabel.isHidden = !(item.isSelected ?? false)
		}
	}
}
