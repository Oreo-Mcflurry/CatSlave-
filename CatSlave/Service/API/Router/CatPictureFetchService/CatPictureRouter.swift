//
//  CatPictureRouter.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import Foundation
import Moya

enum CatPictureRouter {
	case randomImage
}

extension CatPictureRouter: TargetType {
	var baseURL: URL {
		return URL(string: "https://api.thecatapi.com")!
	}
	
	var path: String {
		return "/v1/images/search"
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var task: Task {
		return .requestParameters(parameters: ["limit": 40], encoding: URLEncoding.queryString)
	}
	
	var headers: [String : String]? {
		return [
			HTTPHeaders.catAPIKeyHeader.rawValue: APIKey.catAPIKey.rawValue
		]
	}
}
