//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import Foundation

protocol ModuleNaming {
	var name: ModuleName { get }
	static var identifier: String { get }
}

public enum ModuleName: String, CaseIterable {
	case contact
	case like
	case dislike
	case apps
	case about
	case modules
	case module
}
