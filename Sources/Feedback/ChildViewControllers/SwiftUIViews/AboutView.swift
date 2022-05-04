//
//  AboutView.swift
//  
//
//  Created by Oliver Michalak on 30.12.21.
//

import SwiftUI

struct AboutViewModel {

	let icon: UIImage
	let name: String
	let version: String
	let build: String
	let texts: [AttributedString]
	
	init(icon: UIImage, name: String, version: String, build: String, text: String) {
		self.icon = icon
		self.name = name
		self.version = version
		self.build = build
		self.texts = text.components(separatedBy: "\n\n").compactMap { try? AttributedString(markdown: $0) }
	}

}


struct AboutView: View {

	let model: AboutViewModel

	var body: some View {
		VStack {
			Image(uiImage: model.icon)
				.aspectRatio(1, contentMode: .fit)
				.cornerRadius(10)
				.frame(maxWidth: 60, maxHeight: 60)
			Text(model.name)
				.font(.headline)
			Text("V\(model.version) b\(model.build)")
				.font(.subheadline)
				.foregroundColor(.secondary)
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 10) {
					ForEach(model.texts, id: \.self) { text in
						HStack(alignment: .top, spacing: 0) {
							Text(text)
								.multilineTextAlignment(.leading)
								.font(.body)
							Spacer(minLength: 0)
						}
					}
				}
				.padding(.vertical, 10)
			}
			.mask(
				VStack(spacing: 0) {
					LinearGradient(gradient:
													Gradient(
														colors: [.black.opacity(0), .black]),
												 startPoint: .top, endPoint: .bottom
					)
						.frame(height: 20)

					Rectangle().fill(Color.black)
					
					LinearGradient(gradient:
													Gradient(
														colors: [.black, .black.opacity(0)]),
												 startPoint: .top, endPoint: .bottom
					)
						.frame(height: 20)
				}
			)
		}
		.padding([.leading, .trailing, .top], 10)
	}

}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
			AboutView(model: AboutViewModel(icon: UIImage(systemName: "heart.fill")!, name: "App", version: "1.0", build: "3", text: "The quick brown fox jumps over the lazy dog.\n\nThe quick brown fox jumps over the lazy dog."))
    }
}
