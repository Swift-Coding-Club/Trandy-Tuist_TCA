//
//  TCANavigationPracticeTests.swift
//  TCANavigationPracticeTests
//
//  Created by 현수빈 on 10/28/23.
//

import XCTest
import ComposableArchitecture

@testable import TCANavigationPractice

@MainActor
// 1-1. test code 생성
final class ContactsFeatureTests: XCTestCase {
  func testAddFlow() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: {
        $0.uuid = .incrementing // 증가하는 걸로 통제방식 결정
      }

      // add contact 버튼 눌렀을 때
    await store.send(.addButtonTapped) {
      $0.destination = .addContact(
        AddContactFeature.State(
//          Contact(id: ???, name: "") <- 여기서 임의의 ID랑 Name을 테스트하기란 쉽지 않음 ㅠㅠ 따라서 UUID를 통제될 수 있도록 해줘야 함!!
            contact: Contact(id: UUID(0), name: "")
        )
      )
    }
      
      
      // 1-12. add contact할 때
      await store.send(.destination(.presented(.addContact(.setName("Blob Jr."))))) {
            $0.$destination[case: /ContactsFeature.Destination.State.addContact]?.contact.name = "Blob Jr."
          }
      
      // 1-13. save button을 눌렀을 때
      await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
      await store.receive(
            .destination(
              .presented(.addContact(.delegate(.saveContact(Contact(id: UUID(0), name: "Blob Jr.")))))
            )
          ) {
              $0.contacts = [
                     Contact(id: UUID(0), name: "Blob Jr.")
                   ]
          }
      
      // 1-18. 그리고 잘 사라지는지 테스트
      await store.receive(.destination(.dismiss)) {
           $0.destination = nil
         }
  }
}


// 2. 위에 처럼 작성하니까 모든 플로우를 어떻게 지나갔는지 테스트해야 한다라는 점이 있었음
// 좀 더 쉽게 테스트할 수 없을까??? non-exhaustive testing

