//
//  CatViewModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/15/24.
//

import SwiftUI
import Combine

final class CatViewModel: ObservableObject {
	@Published var selectedCatModel: CatImageDTOModel?
	@Published var leftColumnImages: [CatImageDTOModel] = []
	@Published var rightColumnImages: [CatImageDTOModel] = []
	
	private var leftHeight: CGFloat = .zero
	private var rightHeight: CGFloat = .zero
	
	private let catFetchService = CatPictureService.shared
	private var cancellable = Set<AnyCancellable>()
	
	func fetchCatImages(isRefresh: Bool = false) {
		catFetchService.fetchRandomCatImage()
			.sink(with: self) { error in
				print(error)
			} receiveValue: { owner, value in
				owner.appendImages(value, isRefresh: isRefresh)
			}.store(in: &cancellable)
	}
}

extension CatViewModel {
	private func appendImages(_ data: [CatImageDTOModel], isRefresh: Bool) {
		if isRefresh {
			leftColumnImages = []
			rightColumnImages = []
		}
		
		data.forEach { data in
			if leftHeight < rightHeight {
				leftColumnImages.append(data)
				leftHeight += data.computedHeight
			} else {
				rightColumnImages.append(data)
				rightHeight += data.computedHeight
			}
		}
	}
}
