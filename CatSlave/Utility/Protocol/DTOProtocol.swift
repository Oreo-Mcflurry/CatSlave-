//
//  DTOProtocol.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import Foundation

protocol DTOModel: Hashable, Equatable {
	
}

protocol DTODecodableModel: Decodable {
	associatedtype Model: DTOModel
	func asDTOModel() -> Model
}
