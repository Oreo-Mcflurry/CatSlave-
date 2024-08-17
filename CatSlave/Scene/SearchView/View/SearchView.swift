//
//  SearchView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import SwiftUI

struct SearchView: View {
	@StateObject private var viewModel = SearchViewModel()
	
	var body: some View {
		ScrollView {
			searchBarView(text: $viewModel.searchText)
		}
	}
}

extension SearchView {
	private func searchBarView(text: Binding<String>) -> some View {
		HStack {
			HStack {
				Image(systemName: "magnifyingglass")
				
				TextField("Search", text: text)
					.foregroundColor(.primary)
				
				if !text.wrappedValue.isEmpty {
					Button(action: {
						text.wrappedValue = ""
					}) {
						Image(systemName: "xmark.circle.fill")
					}
				} else {
					EmptyView()
				}
			}
			.padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
			.foregroundColor(.secondary)
			.background(Color(.secondarySystemBackground))
			.cornerRadius(10.0)
		}
		.padding(.horizontal)
	}
}

#if DEBUG
#Preview {
	SearchView()
}
#endif
