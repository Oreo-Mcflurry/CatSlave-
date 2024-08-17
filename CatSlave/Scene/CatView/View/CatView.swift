//
//  CatView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI
import Kingfisher

struct CatView: View {
	@StateObject private var viewModel = CatViewModel()
	
	var body: some View {
		if #available(iOS 15.0, *) {
			gridView
		} else {
			gridViewiOS14
		}
	}
}

extension CatView {
	@available(iOS 15.0, *)
	@ViewBuilder private var gridView: some View {
		OffsetObservableScrollView(scrollOffset: $viewModel.scrollOffset) { _ in
			HStack(alignment: .top) {
				gridViewBuilder(viewModel.leftColumnImages)
				gridViewBuilder(viewModel.rightColumnImages, onAppearDisable: false)
			}
			.padding(.horizontal)
			
			ProgressView()
		}
		.refreshable {
			viewModel.fetchCatImages(isRefresh: true)
		}
	}
	
	@available(iOS 14.0, *)
	@ViewBuilder private var gridViewiOS14: some View {
		ScrollView {
			HStack(alignment: .top) {
				gridViewBuilder(viewModel.leftColumnImages)
				gridViewBuilder(viewModel.rightColumnImages, onAppearDisable: false)
			}
			.padding(.horizontal)
			ProgressView()
		}
	}
	
	private func gridViewBuilder(_ data: [CatImageDTOModel], onAppearDisable: Bool = true) -> some View {
		LazyVStack {
			ForEach(data, id: \.uuid) { item in
				KFImage(item.url)
					.resizable()
					.placeholder {
						Color.gray
							.aspectRatio(item.ratio, contentMode: .fit)
					}
					.serialize(as: .JPEG, jpegCompressionQuality: 0.3)
					.aspectRatio(item.ratio, contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 12))
			}
			
			Color.clear
				.onAppear {
					if !onAppearDisable {
						viewModel.fetchCatImages()
					}
				}
		}
		.frame(maxWidth: .infinity, alignment: .top)
	}
}

#if DEBUG
#Preview {
	CatView()
}
#endif
