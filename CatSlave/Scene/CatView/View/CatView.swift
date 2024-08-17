//
//  CatView.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import SwiftUI
import Kingfisher
import Viewrito

struct CatView: View {
	@StateObject private var viewModel = CatViewModel()
	
    var body: some View {
		ScrollView {
			ForEach(viewModel.catImageDatas, id: \.self) { item in
				KFImage(URL(string: item.url))
			}
		}
		.addViewModifier { view in
			if #available(iOS 15.0, *) {
				view.refreshable {
					viewModel.fetchCatImages()
				}
			}
		}
    }
}

#if DEBUG
#Preview {
	CatView()
}
#endif
