//
//  CatBreedRouter.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import Foundation
import Moya

enum CatBreedRouter {
	case fetchAllbreed
	case fetchbreedInfo
}

extension CatBreedRouter: TargetType {
	var baseURL: URL {
		return URL(string: "https://api.thecatapi.com")!
	}
	
	var path: String {
		return "/v1/breeds"
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var task: Task {
		return .requestParameters(parameters: ["limit": 10], encoding: URLEncoding.queryString)
	}
	
	var headers: [String : String]? {
		return nil
	}
}
