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

	public enum Module: Decodable {
		case contact(ContactModule)
		case apps(String)						/// web URL of all apps
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