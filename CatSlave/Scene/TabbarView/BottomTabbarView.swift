//
//  TabbarView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI

struct BottomTabbarView: View {
	var body: some View {
		
		TabView {
			NavigationWrapper {
				CatView()
			}
			.tabItem {
				Label(
					title: { Text("Cat") },
					icon: { Image(systemName: "cat") }
				)
			}
			
			NavigationWrapper {
				Text("s")
			}
			.tabItem {
				Label(
					title: { Text("Setting") },
					icon: { Image(systemName: "gear") }
				)
			}
		}
	}
}
