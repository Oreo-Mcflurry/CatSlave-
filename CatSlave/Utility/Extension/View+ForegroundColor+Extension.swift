//
//  View+ForegroundColor+Extension.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI

extension View {
	func color(_ color: Color) -> some View {
		modifier(ForegroundStyle(color: color))
	}
}

fileprivate struct ForegroundStyle: ViewModifier {
	let color: Color
	
	func body(content: Content) -> some View {
		if #available(iOS 15.0, *) {
			content
				.foregroundStyle(color)
		} else {
			content
				.foregroundColor(color)
		}
	}
}
