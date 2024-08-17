//
//  CatImageModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/11/24.
//

import Foundation

struct CatImageModel: Decodable, Hashable {
	let id: String
	let url: String
	let width: Int
	let height: Int
}
