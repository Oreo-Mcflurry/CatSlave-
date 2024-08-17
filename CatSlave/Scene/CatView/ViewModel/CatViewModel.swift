//
//  CatViewModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/15/24.
//

import SwiftUI
import Combine

final class CatViewModel: ObservableObject {
	@Published var catImageDatas: [CatImageModel] = []
	
	private let catFetchService = CatPictureService.shared
	private var cancellable = Set<AnyCancellable>()
	
	init() {
		fetchCatImages()
	}
	
	func fetchCatImages() {
		catFetchService.fetchRandomCatImage()
			.sink(with: self) { error in
				print(error)
			} receiveValue: { owner, value in
				owner.catImageDatas = value
			}.store(in: &cancellable)
	}
}
