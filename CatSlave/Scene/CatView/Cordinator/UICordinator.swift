//
//  UICordinator.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import SwiftUI

final class UICordinator: ObservableObject {
	@Published var scrollView: UIScrollView? = .init(frame: .zero)
	@Published var rect: CGRect = .zero
	@Published var animationLayer: UIImage?
	@Published var animateView: Bool = false
	
	@Published var hideLayer: Bool = false
	@Published var hideRootView: Bool = false
}

struct ScrollViewExtractor: UIViewRepresentable {
	var result: (UIScrollView) -> ()

	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		view.backgroundColor = .clear
		view.isUserInteractionEnabled = false
		
		DispatchQueue.main.async {
			if let scrollView = findScrollView(view) {
				result(scrollView)
			}
		}
		
		return view
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {
		// Update code if necessary
	}
	
	private func findScrollView(_ view: UIView) -> UIScrollView? {
		var superview = view.superview
		while superview != nil {
			if let scrollView = superview as? UIScrollView {
				return scrollView
			}
			superview = superview?.superview
		}
		return nil
	}
}
