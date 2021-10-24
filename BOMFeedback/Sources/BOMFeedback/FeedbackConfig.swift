//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import Foundation

struct FeedbackConfig: Decodable {
	struct ContactModule: Decodable {
		enum ContactType: Decodable {
			case store, email, twitter, facebook
		}
		let name = "contact"
		let submodule: String	// class of child viewcontroller
		let email: String
		let services: [ContactType]
		let faqFile: String		// local faq file name
	}
	
	struct AppModule: Decodable {
		let name = "apps"
		let url: String				// url to show your app
	}

	struct AboutModule: Decodable {
		let name = "about"
		let file: String			// local file name with about info
	}
	
	struct ModulesModul: Decodable {
		let name = "modules"
		let files: [String]
	}

	enum Module: Decodable {
		case contact(ContactModule)
		case apps(AppModule)
		case about(AboutModule)
		case modules(ModulesModul)
	}

	let APPId: String
	let ITMSURL: String
	let WebURL: String
	let navigationBarColor: String?
	let modules: [Module]
}
