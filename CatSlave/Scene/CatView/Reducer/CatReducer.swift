//
//  CatReducer.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/10/24.
//

import ComposableArchitecture

@Reducer
struct CatReducer {
	
	@ObservableState
	struct State {
		
	}
	
	enum Action {
		
	}
	
	var body: some Reducer<State, Action> {
		Reduce { state, action in
			switch action {
				// Handle actions here
			}
		}
	}
}
