//
//  MoyaInterceptor.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import Foundation
import Alamofire
import Moya

final class MoyaInterceptor: RequestInterceptor, PluginType {
	private let maxRetryCount: Int
	private var currentRetryCount: Int = 0

	init(maxRetryCount: Int = 3) {
		self.maxRetryCount = maxRetryCount
	}
	
	func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

		guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
		else {
			completion(.doNotRetryWithError(error))
			return
		}
		
		if currentRetryCount < maxRetryCount {
			currentRetryCount += 1
			completion(.retry)
		} else {
			completion(.doNotRetry)
		}
	}
}
