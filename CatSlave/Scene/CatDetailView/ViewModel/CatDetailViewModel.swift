//
//  CatDetailViewModel.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import Foundation

final class CatDetailViewModel: ObservableObject {
	@Published var showShareSheet: Bool = false
	@Published var showToast: Bool = false
	@Published var showProgressToast: Bool = false
	var imageDownloadToastmessage: String = ""
	var shareData: Any = ""
	
	let data: CatImageDTOModel
	private let imageDownloaderService = ImageDownLoaderService.shared
	
	init(data: CatImageDTOModel) {
		self.data = data
	}
	
	func downLoadImage() {
		showProgressToast = true
		imageDownloaderService.downloadAndSaveImage(url: data.url, type: data.type) { [weak self] message in
			DispatchQueue.main.async { [weak self] in
				guard let self else { return }
				showToast = true
				imageDownloadToastmessage = message
				showProgressToast = false
			}
		}
	}
	
	func shareImage() {
		showProgressToast = true
		imageDownloaderService.getImageForShare(url: data.url, type: data.type) { [weak self] gif, image in
			guard let self else { return }
			
			if let gif {
				shareData = gif
			} else if let image {
				shareData = image
			}
			
			DispatchQueue.main.async { [weak self] in
				guard let self else { return }
				showShareSheet = true
				showProgressToast = false
			}
		}
	}
}
