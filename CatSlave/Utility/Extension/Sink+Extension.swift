//
//  Sink+Extension.swift
//  CatSlave
//
//  Created by A_Mcflurry on 8/15/24.
//

import Combine

extension Publisher {
	func sink<Object: AnyObject>(
		with obj: Object,
		receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
		receiveValue: @escaping (Object, Output) -> Void
	) -> AnyCancellable {
		sink { [weak obj] completion in
			guard obj != nil else { return }
			receiveCompletion(completion)
		} receiveValue: { [weak obj] value in
			guard let obj = obj else { return }
			receiveValue(obj, value)
		}
	}
	
	func sink<Object: AnyObject>(
		with obj: Object,
		receiveValue: @escaping (Object, Output) -> Void
	) -> AnyCancellable where Failure == Never {
		sink { [weak obj] value in
			guard let obj = obj else { return }
			receiveValue(obj, value)
		}
	}
}

