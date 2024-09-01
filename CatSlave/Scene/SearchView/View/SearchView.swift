//
//  SearchView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/17/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
	@StateObject private var viewModel = SearchViewModel()
	
	var body: some View {
		ScrollView {
			searchBarView(text: $viewModel.searchText)
			
			LazyVStack {
				LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
					ForEach(viewModel.fetchedBreedInfos, id: \.id) { item in
						KFImage(item.referenceImageID)
							.resizable()
							.frame(height: 300)
							.aspectRatio(contentMode: .fit)
					}
				}
				
				ProgressView()
					.task {
						await viewModel.fetchBreedInfo()
					}
			}
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
			.padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
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
