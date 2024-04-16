//
//  Profile.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct Profile: View {
    @State var user: User
    
    var body: some View {
        NavigationStack {
            List {
                Section("Name") {
                    TextField("Name", text: $user.name, axis: .vertical)
                }
                Section("Email") {
                    TextField("Email", text: $user.email, axis: .vertical)
                }
            }
            .navigationTitle("My Profile")
        }
    }
}

#Preview {
    Profile(user: NoteList().user)
}
