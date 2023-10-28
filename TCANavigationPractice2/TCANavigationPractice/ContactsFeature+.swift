//
//  ContactsFeature+.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//
import ComposableArchitecture

// 2. navigation이 많아지면 복잡해지므로 좀 더 간단하게 모델링하는 방법에 대해서 알아보자!
// navigation과 관련된 feature을 담을 reducer를 생성
extension ContactsFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case addContact(AddContactFeature.State)
            case alert(AlertState<ContactsFeature.Action.Alert>)
        }
        enum Action: Equatable {
            case addContact(AddContactFeature.Action)
            case alert(ContactsFeature.Action.Alert)
        }
        
        var body: some ReducerOf<Self> {
            // 2-7. Scope Reducer를 사용해서 전체가 아닌 domain of reducer에 집중할 수 있음
            Scope(state: /State.addContact, action: /Action.addContact) {
                AddContactFeature()
            }
        }
    }
}
