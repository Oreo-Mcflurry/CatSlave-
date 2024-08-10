//
//  NavigationWrapper.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI

struct NavigationWrapper<Content: View>: View {
	let content: () -> Content

	var body: some View {
		if #available(iOS 16.0, *) {
			NavigationStack {
				content()
			}
		} else {
			NavigationView {
				content()
			}
		}
	}
}
