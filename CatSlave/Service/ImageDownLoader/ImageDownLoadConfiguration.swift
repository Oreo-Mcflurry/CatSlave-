//
//  ImageDownLoadConfiguration.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/18/24.
//

import Foundation

final class ImageDownLoadConfiguration {
	var format: ImageType {
		get {
			return ImageType(rawValue: ImageType.RawValue(integerLiteral: UserDefaults.standard.integer(forKey: "imageFormat"))) ?? .png
		} set {
			UserDefaults.standard.setValue(newValue.rawValue, forKey: "imageFormat")
		}
	}
	
	var downSampling: Double {
		get {
			return UserDefaults.standard.double(forKey: "downSampling")
		} set {
			UserDefaults.standard.setValue(newValue, forKey: "downSampling")
		}
	}
}
