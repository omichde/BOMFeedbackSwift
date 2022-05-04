// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "Feedback",
	defaultLocalization: "en",
	platforms: [
		.iOS("15.0")
	],
	products: [
		.library(
			name: "Feedback",
			targets: ["Feedback"]),
	],
	dependencies: [
	],
	targets: [
		.target(name: "Feedback",
		path: "Feedback/Sources/Feedback",
						resources: [
							.copy("Resources/Feedback-Regular.otf"),
							.copy("Resources/FeedbackStar.sks")
						])
	]
)
