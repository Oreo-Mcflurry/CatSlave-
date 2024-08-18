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
		NavigationWrapper {
			ZoomableScrollView {
				VStack {
					makeImageView(viewModel.data)
				}
				.padding(.horizontal)
			}
			.navigationTitle("Detail")
			.navigationBarTitleDisplayMode(.inline)
			.toast(isPresenting: $viewModel.showToast) {
				AlertToast(type: .regular, title: viewModel.imageDownloadToastmessage)
			}
			.toolbar {
				downloadButtonView
				shareButtonView
			}
			.sheet(isPresented: $viewModel.showShareSheet) {
				ActivityView(activityItems: [viewModel.shareData])
			}
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
	
	private var downloadButtonView: some ToolbarContent {
		ToolbarItem(placement: .topBarTrailing) {
			Button(action: viewModel.downLoadImage) {
				Image(systemName: "square.and.arrow.down")
			}
		}
	}
	
	private var shareButtonView: some ToolbarContent {
		ToolbarItem(placement: .topBarTrailing) {
			Button(action: viewModel.shareImage) {
				Image(systemName: "square.and.arrow.up")
			}
		}
	}
}
