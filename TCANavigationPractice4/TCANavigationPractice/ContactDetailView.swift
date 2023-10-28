//
//  ContactDetailView.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct ContactDetailView: View {
  let store: StoreOf<ContactDetailFeature>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Form {
      }
      .navigationBarTitle(Text(viewStore.contact.name))
    }
  }
}

struct ContactDetailPreviews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ContactDetailView(
        store: Store(
          initialState: ContactDetailFeature.State(
            contact: Contact(id: UUID(), name: "Blob")
          )
        ) {
          ContactDetailFeature()
        }
      )
    }
  }
}
