//
//  CatDetailView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import SwiftUI
import Kingfisher
import AlertToast

struct CatDetailView: View {
	@StateObject private var viewModel: CatDetailViewModel
	init(data: CatImageDTOModel) {
		let viewModel = CatDetailViewModel(data: data)
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	var body: some View {
		ScrollView {
			VStack {
				makeImageView(viewModel.data)
				
				Button(action: viewModel.downLoadImage) {
					Text("DownLoad")
						.padding()
						.background(Color.blue)
						.clipShape(.rect(cornerRadius: 10))
				}
				.frame(maxWidth: .infinity, alignment: .trailing)
			}
			.padding(.horizontal)
		}
		.navigationTitle("Detail")
		.navigationBarTitleDisplayMode(.inline)
		.toast(isPresenting: $viewModel.showToast) {
			AlertToast(type: .regular, title: viewModel.imageDownloadToastmessage)
		}
	}
}

extension CatDetailView {
	@ViewBuilder
	private func makeImageView(_ item: CatImageDTOModel) -> some View {
		if item.type == .png {
			KFImage(item.url)
				.resizable()
				.placeholder {
					Color.gray
						.aspectRatio(item.ratio, contentMode: .fit)
				}
				.serialize(as: .JPEG, jpegCompressionQuality: 0.3)
				.aspectRatio(item.ratio, contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 12))
		} else {
			KFAnimatedImage(item.url)
				.placeholder {
					Color.gray
						.aspectRatio(item.ratio, contentMode: .fit)
				}
				.aspectRatio(item.ratio, contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 12))
		}
	}
}
