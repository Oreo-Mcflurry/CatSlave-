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
	
	var body: some View {
		if item.type == .png {
			KFImage(item.url)
				.resizable()
				.placeholder {
					Color.gray
						.aspectRatio(item.ratio, contentMode: .fit)
				}
				.serialize(as: .JPEG, jpegCompressionQuality: 0.3)
				.aspectRatio(item.ratio, contentMode: .fit)
				.clipShape(.rect(cornerRadius: 12))
				.overlay {
					RoundedRectangle(cornerRadius: 12)
						.strokeBorder(.gray.opacity(0.8))
				}
			
		} else {
			KFAnimatedImage(item.url)
				.placeholder {
					Color.gray
						.aspectRatio(item.ratio, contentMode: .fit)
				}
				.aspectRatio(item.ratio, contentMode: .fit)
				.clipShape(.rect(cornerRadius: 12))
				.overlay {
					RoundedRectangle(cornerRadius: 12)
						.strokeBorder(.gray.opacity(0.8))
				}
		}
	}
}
