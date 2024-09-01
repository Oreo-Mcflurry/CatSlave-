//
//  CatBreedDTOModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/27/24.
//

import Foundation

struct CatBreedDTOModel: DTOModel {
	let id: String
	let name: String
	let referenceImageID: URL?
	let wikipediaURL: URL?
}
