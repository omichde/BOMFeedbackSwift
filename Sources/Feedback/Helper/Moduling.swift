//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import Foundation

protocol ModuleNaming {

	static var identifier: String { get }
	var name: ModuleName! { get set }

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
