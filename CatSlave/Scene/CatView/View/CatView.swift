//
//  CatView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI
import ComposableArchitecture

struct CatView: View {
	init(
		store: StoreOf<CatReducer> = 
		Store(initialState: CatReducer.State()) {
			CatReducer()
		}
	) {
		self.store = store
	}
	
	let store: StoreOf<CatReducer>
    var body: some View {
        Text("Hello, World!")
			.color(.orange)
    }
}

#if DEBUG
#Preview {
	CatView()
}
#endif
