//
//  FeedbackConfig.swift
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
		case contact(ContactModule)	/// contact tab
		case apps(String)						/// apps tab, web URL of all apps
		case about(String)					/// about tab, name of about file
		case modules([String])			/// modules tabs, name of all readme files (rtf, html, pdf)
	}

	public let APPId: String			/// app store id
	public let ITMSURL: String		/// app store url string
	public let navigationBarColor: String?	/// hex code for navigation bar color
	public let modules: [Module]	/// list of tabs/modules

	public init (APPId: String, ITMSURL: String, navigationBarColor: String? = nil, modules: [Module] = []) {
		self.APPId = APPId
		self.ITMSURL = ITMSURL
		self.navigationBarColor = navigationBarColor
		self.modules = modules
	}

}
