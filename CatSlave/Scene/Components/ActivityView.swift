//
//  ActivityView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import SwiftUI
import UIKit

struct ActivityView: UIViewControllerRepresentable {
	var activityItems: [Any]
	var applicationActivities: [UIActivity]? = nil
	var excludedActivityTypes: [UIActivity.ActivityType]? = nil

	func makeUIViewController(context: Context) -> UIActivityViewController {
		let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
		controller.excludedActivityTypes = excludedActivityTypes
		return controller
	}

	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
