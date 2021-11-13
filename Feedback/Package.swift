// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "Feedback",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v13)
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
						resources: [
							.copy("Resources/Feedback-Regular.otf"),
							.copy("Resources/FeedbackStar.sks")
						])
	]
)
