//
//  View+Version+Extension.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import Foundation

enum VersionFetchService { }

extension VersionFetchService {
	static func getCurrentVersion() -> String {
		guard let dictionary = Bundle.main.infoDictionary,
			  let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
		return version
	}
	
	static func getUpdatedVersion() -> String {
		guard let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.muskyoo.CatSlave"),
			  let data = try? Data(contentsOf: url),
			  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
			  let results = json["results"] as? [[String: Any]],
			  results.count > 0,
			  let appStoreVersion = results[0]["version"] as? String else { return "" }
		return appStoreVersion
	}
	
	static var isUpdateRequired: Bool {
		return getCurrentVersion() != getUpdatedVersion()
	}
}
