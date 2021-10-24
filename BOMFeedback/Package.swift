// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "BOMFeedback",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v12)
	],
	products: [
		.library(
			name: "BOMFeedback",
			targets: ["BOMFeedback"]),
	],
	dependencies: [
	],
	targets: [
		.target(name: "BOMFeedback",
						resources: [
							.copy("Resources/Feedback-Regular.otf"),
							.copy("Resources/FeedbackStar.sks")
						])
	]
)
