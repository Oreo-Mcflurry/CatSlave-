//
//  NavigationLazyView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import SwiftUI

struct NavigationLazyView<T: View>: View {
	let build: () -> T

	init(_ build: @autoclosure @escaping () -> T) {
		self.build = build
	}

	var body: some View {
		build()
	}
}
