//
//  CatImageDTOModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import Foundation

struct CatImageDTOModel: DTOModel {
	var uuid = UUID()
	let id: String
	let url: URL?
	let computedHeight: CGFloat
	let ratio: CGFloat
	let type: ImageType
}
