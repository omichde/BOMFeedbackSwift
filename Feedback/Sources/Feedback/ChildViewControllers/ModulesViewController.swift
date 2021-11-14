//
//  File.swift
//  
//
//  Created by Oliver Michalak on 14.11.21.
//

import UIKit

class ModulesViewController: UIViewController {
	var modules: [String]?
	var feedbackConfig: FeedbackConfig?

	@IBOutlet weak var tableView: UITableView!
	private var datasource: UITableViewDiffableDataSource<Int, String>!
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)

		title = "Modules".localized
		tabBarItem = UITabBarItem(title: "Modules".localized, image: UIImage(systemName: "plusminus.circle"), selectedImage: UIImage(systemName: "plusminus.circle.fill"))
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
		
		let url = URL(fileURLWithPath: modules[indexPath.row], relativeTo: Bundle.main.bundleURL)
		if let modulViewController = storyboard?.instantiateViewController(withIdentifier: ModulViewController.identifier) as? ModulViewController {
			modulViewController.moduleURL = url
			navigationController?.pushViewController(modulViewController, animated: true)
		}
	}
}

extension ModulesViewController: ModuleNaming {
	var name: ModuleName { .modules }
	static var identifier: String { String(describing: self) }
}
