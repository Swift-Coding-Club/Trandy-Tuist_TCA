//
//  ContactsdFeatureTests.swift
//  TCANavigationPracticeTests
//
//  Created by 현수빈 on 10/28/23.
//

import XCTest
import ComposableArchitecture
// 2. 위에 처럼 작성하니까 모든 플로우를 어떻게 지나갔는지 테스트해야 한다라는 점이 있었음
// 좀 더 쉽게 테스트할 수 없을까??? non-exhaustive testing

@testable import TCANavigationPractice

@MainActor
final class ContactsFeatureTests2: XCTestCase {
  func testAddFlow_NonExhaustive() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: {
      $0.uuid = .incrementing
    }
      
      // testStore의 소모 수준을 의미, off로 설정한다면 state change를 테스트하고 싶지 않은 부분은 안해도 괜찮음!!
      store.exhaustivity = .off
      
      await store.send(.addButtonTapped) // 2-3. 따라서 여기서 체크할 필요 없어짐!
      await store.send(.destination(.presented(.addContact(.setName("Blob Jr.")))))
      await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
      // 2-6. we cannot assert on that until all the actions have been received, and so we can do that by using skipReceivedActions
      await store.skipReceivedActions()
      store.assert {
           $0.contacts = [
             Contact(id: UUID(0), name: "Blob Jr.")
           ]
           $0.destination = nil
         }
  }
    
    // 3. 이제 delete도 테스트해보자!
    func testDeleteContact() async {
       let store = TestStore(
         initialState: ContactsFeature.State(
           contacts: [
             Contact(id: UUID(0), name: "Blob"),
             Contact(id: UUID(1), name: "Blob Jr."),
           ]
         )
       ) {
         ContactsFeature()
       }

        // 3-6
//       await store.send(.deleteButtonTapped(id: UUID(1))) {
//         $0.destination = .alert(
//           AlertState {
//             TextState("Are you sure?")
//           } actions: {
//             ButtonState(role: .destructive, action: .confirmDeletion(id: UUID(1))) {
//               TextState("Delete")
//             }
//           }
//         )
//       }
        // 3-8. boilerplate 코드를 extension으로 빼서 처리
        await store.send(.deleteButtonTapped(id: UUID(1))) {
             $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
           }
        
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
             $0.contacts.remove(id: UUID(1))
             $0.destination = nil
           }
     }
}
