//
//  SearchViewModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
	@Published var searchText: String = ""
	@Published var fetchedBreedInfos: [CatBreedDTOModel] = []
	private var cancellable = Set<AnyCancellable>()
	private let breedFetchService = CatBreedService.shared
	
	func fetchBreedInfo() async {
		await withCheckedContinuation { [weak self] continuation in
			guard let self else { return }
			breedFetchService.fetchRandomCatImage()
				.sink(with: self) { error in
					print(error)
//					continuation.resume()
				} receiveValue: { owner, data in
					owner.fetchedBreedInfos.append(contentsOf: data)
					continuation.resume()
				}
				.store(in: &cancellable)
		}
	}
}
