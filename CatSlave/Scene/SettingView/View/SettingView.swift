//
//  SettingView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import SwiftUI

struct SettingView: View {
	var body: some View {
		List {
			
			NavigationLink("Privacy Policy") {
				NavigationLazyView(WebView(url: URL(string: "https://alex-ios.notion.site/Privacy-Policy-8a894b80f8e24a7b86e7cafbd42f8458")!))
					.navigationTitle("Privacy Policy")
					.navigationBarTitleDisplayMode(.inline)
			}
			
			NavigationLink("Library") {
				NavigationLazyView(libraryView)
			}
			
			HStack {
				Text("Current Version")
				Spacer()
				Text(VersionFetchService.getCurrentVersion())
			}
		}
		.listStyle(.inset)
		.navigationTitle("Setting")
	}
}

extension SettingView {
	private var libraryView: some View {
		List {
			ForEach(UsageLibrary.allCases, id: \.rawValue) { item in
				NavigationLink(item.rawValue) {
					NavigationLazyView(WebView(url: item.url))
						.navigationTitle(item.rawValue)
						.navigationBarTitleDisplayMode(.inline)
				}
			}
		}
		.listStyle(.inset)
		.navigationTitle("Library")
		.navigationBarTitleDisplayMode(.inline)
	}
	
	private enum UsageLibrary: String, CaseIterable {
		case moya = "Moya"
		case firebase = "Firebase"
		case IQkeyboardManager = "IQKeyboardManagerSwift"
		case realm = "Realm"
		case viewrito = "Viewrito"
		case kingfisher = "KingFisher"
		case alertToast = "AlertToast"
		
		var url: URL {
			switch self {
			case .moya:
				return URL(string: "https://github.com/Moya/Moya.git")!
			case .firebase:
				return URL(string: "https://github.com/firebase/firebase-ios-sdk.git")!
			case .IQkeyboardManager:
				return URL(string: "https://github.com/hackiftekhar/IQKeyboardManager.git")!
			case .realm:
				return URL(string: "https://github.com/realm/realm-swift.git")!
			case .viewrito:
				return URL(string: "https://github.com/mgdgc/Viewrito.git")!
			case .kingfisher:
				return URL(string: "https://github.com/onevcat/Kingfisher.git")!
			case .alertToast:
				return URL(string: "https://github.com/elai950/AlertToast.git")!
			}
		}
	}
}

#if DEBUG
#Preview {
	NavigationWrapper {
		SettingView()
	}
}
#endif
