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
		gridView
	}
}

extension CatView {
	@ViewBuilder
	private var gridView: some View {
		ScrollView {
			HStack(alignment: .top) {
				gridViewBuilder(viewModel.leftColumnImages)
				gridViewBuilder(viewModel.rightColumnImages, onAppearDisable: false)
			}
			.padding(.horizontal)
			
			ProgressView()
		}
		.addViewModifier { view in
			if #available(iOS 15.0, *) {
				view.refreshable {
						viewModel.fetchCatImages(isRefresh: true)
					}
			}
		}
	}
	
	private func gridViewBuilder(_ data: [CatImageDTOModel], onAppearDisable: Bool = true) -> some View {
		LazyVStack {
			ForEach(data, id: \.uuid) { item in
				if item.type == .jpg {
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
