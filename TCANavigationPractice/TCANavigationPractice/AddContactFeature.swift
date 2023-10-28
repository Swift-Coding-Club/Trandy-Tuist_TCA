//
//  AddContactFeature.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//
import ComposableArchitecture
import SwiftUI

// 1-4. 연락처를 추가하는 feature을 추가
struct AddContactFeature: Reducer {
    struct State: Equatable {
        var contact: Contact
    }
    enum Action: Equatable {
        case cancelButtonTapped
        case delegate(Delegate) // 4-1. 3까지를 보면 parent가 child의 action을 직접 처리하고 있었는데 이게 좋은 게 아니니 delegate action으로 부모가 해야할 일을 정확하게 정의해서 사용해보자!
        case saveButtonTapped
        case setName(String)
        
        
        enum Delegate: Equatable {
//            case cancel 4-7. 이제 cancel은 무시해도 되니까 지우자!
            case saveContact(Contact)
        }
    }
    
    // 4-5. 하지만 cancel같은 거는 사실 부모가 무시해도 되는 거자나! 새로운 도구를 이용해보쟈
    // DismissEffect라는 걸 받아서 child feature가 parent feature와 접촉하지 않고 무시할 수 있는 값을 의미
    @Dependency(\.dismiss) var dismiss
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .cancelButtonTapped:
//            return .none //4-2. delegate 패턴으로 변경
//            return .send(.delegate(.cancel))
            return .run { _ in await self.dismiss() } // 4-6 effect를 반환하고 무시함. dismiss는 async이므로 effect에섯만 호출하는 것이 적절
            
        case .saveButtonTapped:
//            return .none
//            return .send(.delegate(.saveContact(state.contact)))
            // 4-6
            return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                  }
            
        case let .setName(name):
            state.contact.name = name
            return .none
            
        case .delegate:
              return .none
        }
    }
}

