//
//  MarkdownView.swift
//
//
//  Created by Oliver Michalak on 08.01.22.
//

import SwiftUI

struct MarkdownViewModel {
	let texts: [AttributedString]
	
	init(_ text: String) {
		self.texts = text.components(separatedBy: "\n\n").compactMap { try? AttributedString(markdown: $0) }
	}
}

struct MarkdownView: View {
	let model: MarkdownViewModel

	var body: some View {
		VStack {
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
		}
		.padding([.leading, .trailing, .top], 10)
	}
}

struct MarkdownView_Previews: PreviewProvider {
		static var previews: some View {
			MarkdownView(model: MarkdownViewModel("The *quick* **brown** [fox](https://en.wikipedia.org/wiki/Fox) jumps over the lazy dog.\n\nThe quick brown fox jumps over the lazy dog."))
		}
}
