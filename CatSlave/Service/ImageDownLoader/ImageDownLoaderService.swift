//
//  ImageDownLoaderService.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import UIKit
import Photos

final class ImageDownLoaderService {
	static let shared = ImageDownLoaderService()
	private init() { }
	
	private let configuration = ImageDownLoadConfiguration()
	
	func downloadAndSaveImage(url: URL?, type: ImageType, completion: @escaping (String)->()) {
		guard let imageUrl = url else { return }
		
		URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
			guard let self else { return }
			if error != nil {
				completion("Error! Please try later")
				return
			}
			
			guard let data = data, let image = UIImage(data: data) else {
				completion("Error! Please try later")
				return
			}
			
			if type == .gif {
				saveGifToAlbum(data, completion: completion)
			} else if configuration.format == .jpeg {
				if let jpeg = image.jpegData(compressionQuality: configuration.downSampling) {
					if let jpegImage = UIImage(data: jpeg) {
						self.saveImageToAlbum(jpegImage, completion: completion)
					} else {
						completion("Error! Please try later")
						return
					}
				} else {
					completion("Error! Please try later")
					return
				}
			} else {
				self.saveImageToAlbum(image, completion: completion)
			}
		}.resume()
	}
	
	private func saveImageToAlbum(_ image: UIImage, completion: @escaping (String)->()) {
		PHPhotoLibrary.requestAuthorization { status in
			if status == .authorized {
				PHPhotoLibrary.shared().performChanges({
					PHAssetChangeRequest.creationRequestForAsset(from: image)
				}) { success, error in
					if success {
						completion("Image saved successfully!")
					} else if error != nil {
						completion("Error! Please try later")
					}
				}
			} else {
				completion("Error! Please enable photo album permissions.")
			}
		}
	}
	
	private func saveGifToAlbum(_ gifData: Data, completion: @escaping (String) -> ()) {
		PHPhotoLibrary.requestAuthorization { status in
	  guard status == .authorized else {
		  completion("Permission denied. Please allow photo library access in Settings.")
		  return
	  }
	  
	  PHPhotoLibrary.shared().performChanges({
		  let options = PHAssetResourceCreationOptions()
		  let request = PHAssetCreationRequest.forAsset()
		  request.addResource(with: .photo, data: gifData, options: options)
	  }) { success, error in
		  if success {
			  completion("GIF saved successfully!")
		  } else {
			  completion("Error! Please try later")
		  }
	  }
  }
}
}
