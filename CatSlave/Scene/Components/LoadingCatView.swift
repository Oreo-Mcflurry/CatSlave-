//
//  LoadingCatView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import SwiftUI
import Kingfisher

struct LoadingCatView: View {
	var body: some View {
		VStack {
			if let gifPath = Bundle.main.path(forResource: "loadingCat", ofType: "gif") {
				let gifURL = URL(fileURLWithPath: gifPath)
				
				KFAnimatedImage(gifURL)
					.frame(width: 220, height: 191)
					.clipShape(.rect(cornerRadius: 12))
			} else {
				ProgressView()
			}
		}
	}
}
