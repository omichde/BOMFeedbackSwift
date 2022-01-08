//
//  File.swift
//  
//
//  Created by Oliver Michalak on 08.01.22.
//

import Foundation
import SwiftUI
import CryptoKit

extension FeedbackConfig {

	func remoteURL(_ name: String) -> URL? {
		guard let url = URL(string: name), let scheme = url.scheme, scheme != "file" else { return nil }
		return url
	}

	func localURL(_ name: String) -> URL? {
		let fm = FileManager.default
		if let remoteURL = remoteURL(name) {
			var localURL = fm.urls(for: .cachesDirectory, in: .userDomainMask).first!
			var filename = remoteURL.lastPathComponent
			if filename.isEmpty {
				let md5 = Insecure.MD5.hash(data: name.data(using: .utf8)!)
				let md5Name = md5.enumerated().compactMap({ String(format: "%x", $0.1) }).joined(separator: "")
				filename = md5Name + ".md"
			}
			localURL.appendPathComponent(filename)
			return localURL
		}
		else {
			let url = URL(fileURLWithPath: name, relativeTo: Bundle.main.bundleURL)
			if fm.fileExists(atPath: url.path) {
				return url
			}
		}
		return nil
	}

	public func update() {
		for module in modules {
			switch module {
			case let .apps(link):
				update(name: link)
				
			case let .about(link):
				update(name: link)

			default: ()
			}
		}
	}

	func update(name: String) {
		guard let localURL = localURL(name), let remoteURL = remoteURL(name) else { return }

		let fm = FileManager.default
		var changedDate = Date(timeIntervalSince1970: 0)
		if fm.fileExists(atPath: localURL.path),
			 let attr = try? fm.attributesOfItem(atPath: localURL.path),
			let date = attr[.modificationDate] as? Date {
			changedDate = date
		}

		// once a day
		guard changedDate.timeIntervalSinceNow < -60*60*24 else { return }

		var comp = URLComponents(url: remoteURL, resolvingAgainstBaseURL: false)!
		comp.queryItems = [URLQueryItem(name: "locale", value: Locale.current.identifier),
											 URLQueryItem(name: "src", value: Bundle.main.name)]
		
		guard let url = comp.url else { return }

		let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
			if let data = data, !data.isEmpty {
				try? fm.removeItem(at: localURL)
				try? data.write(to: localURL)
			}
		}
		task.resume()
	}
}
