//
//  File.swift
//  
//
//  Created by Oliver Michalak on 13.11.21.
//

import UIKit
import MessageUI

class DislikeViewController: UIViewController, ModuleNaming {

	static var identifier: String { String(describing: self) }
	var name: ModuleName!
	var feedbackConfig: FeedbackConfig?
	var moduleConfig: FeedbackConfig.ContactModule?

	@IBOutlet weak var emailButton: UIButton!
	@IBOutlet weak var faqTable: UITableView!
	private var faq: FAQ!

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		name = .dislike
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		faqTable.tableHeaderView = UIView(frame: .zero)
		faqTable.tableFooterView = UIView(frame: .zero)

		if let config = moduleConfig {
			faq = FAQ(filename: config.faqFile, tableView: faqTable)
			faqTable.dataSource = faq
			
			var snapshot = NSDiffableDataSourceSnapshot<Int, FAQItem>()
			snapshot.appendSections([0])
			snapshot.appendItems(faq.list, toSection: 0)
			faq.apply(snapshot, animatingDifferences: false)
			
			emailButton.setTitle(config.email, for: .normal)
		}
		else {
			faq = FAQ(tableView: faqTable)
		}
	}

}


extension DislikeViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

	@IBAction func email() {
		guard let email = moduleConfig?.email, MFMailComposeViewController.canSendMail() else { return }

		let emailer = MFMailComposeViewController()
		emailer.delegate = self
		emailer.setToRecipients([email])
		emailer.setSubject("Report-Subject".localized)
		
		var text = "Report-Template".localized
		[("LOCALE", Locale.current.identifier),
		 ("ITMSURL", feedbackConfig?.ITMSURL ?? ""),
		 ("APPVERSION", Bundle.main.version),
		 ("MODEL", UIDevice.current.localizedModel),
		 ("SYSTEMVERSION", UIDevice.current.systemVersion)
		].forEach { (key, value) in
			text = text.replacingOccurrences(of: key, with: value)
		}
		emailer.setMessageBody(text, isHTML: false)
		
		present(emailer, animated: true)
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true)
	}

}


extension DislikeViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		faq.toggle(indexPath)
	}

}
