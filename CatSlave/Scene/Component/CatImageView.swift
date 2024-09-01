//
//  CatImageView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 9/1/24.
//

import SwiftUI
import Kingfisher

struct CatImageView: View {
	let item: CatImageDTOModel
	@State var data: Data?
	
	var body: some View {
		Group {
			if item.type == .png {
				loadImageView(url: item.url)
					.onSuccess { data = $0.data() }
			} else {
				loadAnimatedImageView(url: item.url)
					.onSuccess { data = $0.data() }
			}
		}
		.aspectRatio(item.ratio, contentMode: .fit)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.strokeBorder(Color.gray.opacity(0.8))
		}
	}
	
	private func loadImageView(url: URL?) -> KFImage {
		KFImage(url)
			.resizable()
			.placeholder {
				Color.gray
					.aspectRatio(item.ratio, contentMode: .fit)
			}
			.serialize(as: .JPEG, jpegCompressionQuality: 0.3)
	}
	
	private func loadAnimatedImageView(url: URL?) -> KFAnimatedImage {
		KFAnimatedImage(url)
			.placeholder {
				Color.gray
					.aspectRatio(item.ratio, contentMode: .fit)
			}
	}
}
