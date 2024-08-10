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
		return "/v1/images/search?limit=20"
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var task: Moya.Task {
	 	return .requestPlain
	}
	
	var headers: [String : String]? {
		return [
			HTTPHeaders.catAPIKeyHeader.rawValue: APIKey.catAPIKey.rawValue
		]
	}
}
