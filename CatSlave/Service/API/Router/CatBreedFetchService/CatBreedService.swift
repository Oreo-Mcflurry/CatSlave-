//
//  CatBreedService.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/27/24.
//

import Foundation
import Moya
import CombineMoya
import Combine

final class CatBreedService {
	static let shared = CatBreedService()
	private init() { }
	
	private let provider = MoyaProvider<CatBreedRouter>(plugins: [MoyaLoggingPlugin(), MoyaInterceptor()])
	
	func fetchRandomCatImage() -> AnyPublisher<[CatBreedDTOModel], MoyaError> {
		return provider.requestPublisher(.fetchbreed)
			.map([CatBreedModel].self)
			.map { catBreedModels in
				catBreedModels.map { $0.asDTOModel() }
			}
			.eraseToAnyPublisher()
	}
}

