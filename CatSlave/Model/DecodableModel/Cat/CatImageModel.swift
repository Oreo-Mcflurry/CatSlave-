//
//  CatImageModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/11/24.
//

import Foundation

struct CatImageModel: DTODecodableModel {
	let id: String
	let url: String
	let width: Int
	let height: Int
	
	func asDTOModel() -> CatImageDTOModel {
		let ratio: CGFloat = {
			guard width != 0 else { return 0 }
			return CGFloat(width) / CGFloat(height)
		}()
		
		let type: ImageType = {
			if url.suffix(3).lowercased() == "gif" {
				return .gif
			} else {
				return .jpg
			}
		}()
		
		return CatImageDTOModel(
			id: id,
			url: URL(string: url),
			computedHeight: (CGFloat(height) * 300) / CGFloat(width),
			ratio: ratio,
			type: type
		)
	}
}
