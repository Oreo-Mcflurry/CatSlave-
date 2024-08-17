//
//  CatPictureProvider.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/11/24.
//

import Foundation
import Moya
import CombineMoya
import Combine

final class CatPictureService {
	static let shared = CatPictureService()
	private init() { }
	
	private let provider = MoyaProvider<CatPictureRouter>(plugins: [MoyaLoggingPlugin()])
	
	func fetchRandomCatImage() -> AnyPublisher<[CatImageModel], MoyaError> {
		return provider.requestPublisher(.randomImage)
			.map([CatImageModel].self)
	}
}

