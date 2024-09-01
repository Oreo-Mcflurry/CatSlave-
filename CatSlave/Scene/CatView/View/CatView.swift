//
//  CatView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI
import Kingfisher
import Viewrito

struct CatView: View {
	@StateObject private var viewModel = CatViewModel()

	var body: some View {
		if viewModel.leftColumnImages.isEmpty {
			LoadingCatView()
				.task {
					await viewModel.fetchCatImages()
				}
		} else {
			gridView
				.sheet(item: $viewModel.selectedCatModel, onDismiss: {
					viewModel.selectedCatModel = nil
				}) { data in
					CatDetailView(data: data)
				}
		}
	}
}

extension CatView {
	@ViewBuilder
	private var gridView: some View {
		ScrollView {
			HStack(alignment: .top, spacing: 15) {
				gridViewBuilder(viewModel.leftColumnImages)
				gridViewBuilder(viewModel.rightColumnImages, onAppearDisable: false)
			}
			.padding(.horizontal)
			
			ProgressView()
		}
		.refreshable {
			await viewModel.fetchCatImages(isRefresh: true)
		}
	}
	
	private func gridViewBuilder(_ data: [CatImageDTOModel], onAppearDisable: Bool = true) -> some View {
		LazyVStack(spacing: 15) {
			ForEach(data, id: \.uuid) { item in
				Button {
					viewModel.selectedCatModel = item
				} label: {
					CatImageView(item: item)
				}
				
			}
			
			Color.clear
				.task {
					if !onAppearDisable {
						await viewModel.fetchCatImages()
					}
				}
		}
		.frame(maxWidth: .infinity)
	}
}

#if DEBUG
#Preview {
	CatView()
}
#endif
