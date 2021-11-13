//
//  File.swift
//  
//
//  Created by Oliver Michalak on 13.11.21.
//

import Foundation

extension String {
	var localized: String {
		Bundle.module.localizedString(forKey: self, value: nil, table: "FeedbackLocalizable")
	}
}
