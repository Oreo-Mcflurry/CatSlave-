//
//  CatDetailViewModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import Foundation

final class CatDetailViewModel: ObservableObject {
	@Published var showToast: Bool = false
	var imageDownloadToastmessage: String = ""
	
	let data: CatImageDTOModel
	private let imageDownloaderService = ImageDownLoaderService.shared
	
	init(data: CatImageDTOModel) {
		self.data = data
	}
	
	func downLoadImage() {
		imageDownloaderService.downloadAndSaveImage(url: data.url, type: data.type) { [weak self] message in
			DispatchQueue.main.async { [weak self] in
				guard let self else { return }
				showToast = true
				imageDownloadToastmessage = message
			}
		}
	}
}
