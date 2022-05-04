//
//  File.swift
//  
//
//  Created by Oliver Michalak on 13.11.21.
//

import UIKit

class FAQ: UITableViewDiffableDataSource<Int, FAQItem> {

	var list: [FAQItem]
	
	init(filename: String? = nil, tableView: UITableView) {
		guard let filename = filename,
					case let file = URL(fileURLWithPath: filename, relativeTo: Bundle.main.bundleURL),
					let data = try? Data(contentsOf: file)
		else {
			self.list = []
			super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
				nil
			}
			return
		}

		if file.pathExtension == "json",
			 let list = try? JSONDecoder().decode([FAQItem].self, from: data) {
			self.list = list
		}
		else if file.pathExtension == "plist",
			 let list = try? PropertyListDecoder().decode([FAQItem].self, from: data) {
			self.list = list
		}
		else {
			self.list = []
		}
		
		super.init(tableView: tableView) { tableView, indexPath, item in
			guard let cell = tableView.dequeueReusableCell(withIdentifier: DislikeCell.identifier) as? DislikeCell
			else { return nil }
			cell.item = item
			return cell
		}
	}
	
	func toggle(_ indexPath: IndexPath) {
		let isSelected = list[indexPath.row].isSelected ?? false
		var result = list.map { $0.with(isSelected: false) }
		result[indexPath.row] = list[indexPath.row].with(isSelected: !isSelected)
		list = result
		
		var snap = snapshot()
		snap.deleteAllItems()
		snap.appendSections([0])
		snap.appendItems(list, toSection: 0)
		snap.reloadSections([0])
		apply(snap, animatingDifferences: true)
	}

}


struct FAQItem: Decodable, Hashable {

	let question: String
	let answer: String
	let isSelected: Bool?
	
	func with(isSelected: Bool) -> FAQItem {
		FAQItem(question: question, answer: answer, isSelected: isSelected)
	}

}
