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
	@Published var refreshedEnded: Bool = false
	
	private var leftHeight: CGFloat = .zero
	private var rightHeight: CGFloat = .zero
	
	private let catFetchService = CatPictureService.shared
	private var cancellable = Set<AnyCancellable>()
	
	func fetchCatImages(isRefresh: Bool = false) async {
		// Combine Future를 생성하여 async로 변환
		await withCheckedContinuation { [weak self] continuation in
			guard let self else { return }
			catFetchService.fetchRandomCatImage()
				.sink(with: self) { error in
					print(error)
//					continuation.resume()
				} receiveValue: { owner, data in
					owner.appendImages(data, isRefresh: isRefresh)
					continuation.resume()
				}
				.store(in: &cancellable)
		}
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
