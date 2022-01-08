//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import UIKit
import SwiftUI

class ModulesViewController: UIViewController, ModuleNaming {
	static var identifier: String { String(describing: self) }
	var name: ModuleName!
	var modules: [String]?
	var feedbackConfig: FeedbackConfig?

	@IBOutlet weak var tableView: UITableView!
	private var datasource: UITableViewDiffableDataSource<Int, String>!
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)

		title = "Modules".localized
		tabBarItem = UITabBarItem(title: "Modules".localized, image: UIImage(systemName: "puzzlepiece"), selectedImage: UIImage(systemName: "puzzlepiece.fill"))
		name = .modules
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		datasource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, module in
			var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "ModuleCell")
			if nil == cell {
				cell = UITableViewCell(style: .default, reuseIdentifier: "ModuleCell")
			}
			
			cell?.textLabel?.text = module.removeSuffix()
			return cell
		}

		if let modules = modules {
			var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
			snapshot.appendSections([0])
			snapshot.appendItems(modules, toSection: 0)
			datasource.apply(snapshot, animatingDifferences: false)
		}
	}
}

extension ModulesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard let modules = modules else { return }

		let name = modules[indexPath.row]
		if let url = feedbackConfig?.localURL(name), let text = try? String(contentsOf: url),
			 let vc = storyboard?.instantiateViewController(withIdentifier: HostViewController.identifier) as? HostViewController {
			vc.title = name.removeSuffix()
			vc.name = .module
			vc.contentView = AnyView(MarkdownView(model: MarkdownViewModel(text)))
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}
