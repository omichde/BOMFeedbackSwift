//
//  File.swift
//  
//
//  Created by Oliver Michalak on 24.10.21.
//

import Foundation

public struct FeedbackConfig: Decodable {
	public struct ContactModule: Decodable {
		public enum ContactType: Decodable {
			case store, email, twitter, facebook
		}
		let email: String						/// email
		let services: [ContactType]	/// list of contact services
		let faqFile: String					/// local faq file name
		let submodule: String?			/// class of child viewcontroller

		public init(email: String, services: [ContactType], faqFile: String, submodule: String? = nil) {
			self.email = email
			self.services = services
			self.faqFile = faqFile
			self.submodule = submodule
		}
	}
	
//	public struct AppModule: Decodable {
////		let name = "apps"
//		let url: String				// url to show your app
//
//		public init(url: String) {
//			self.url = url
//		}
//	}
//
//	public struct AboutModule: Decodable {
////		let name = "about"
//		let file: String			// local file name with about info
//
//		public init(file: String) {
//			self.file = file
//		}
//	}
//
//	public struct ModulesModul: Decodable {
////		let name = "modules"
//		let files: [String]
//
//		public init(files: [String]) {
//			self.files = files
//		}
//	}

	public enum Module: Decodable {
		case contact(ContactModule)
		case apps(String)						/// URL of all apps
		case about(String)					/// name of about.html file
		case modules([String])			/// name of all readme files (rtf, html, pdf)
	}

	public let APPId: String
	public let ITMSURL: String
	public let webURL: String
	public let navigationBarColor: String?
	public let modules: [Module]

	public init (APPId: String, ITMSURL: String, webURL: String, navigationBarColor: String? = nil, modules: [Module] = []) {
		self.APPId = APPId
		self.ITMSURL = ITMSURL
		self.webURL = webURL
		self.navigationBarColor = navigationBarColor
		self.modules = modules
	}
}
