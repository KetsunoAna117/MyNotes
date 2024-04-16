//
//  Database.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import Foundation

class NoteList: ObservableObject {
    @Published var notes: [Notes]
    @Published var user: User
    
    init() {
        self.user = User(name: "Deez", email: "ligmajokes@co.id")
        self.notes = [
            Notes(
                title: "Puisi Lorem Ipsum",
                content: """
                    Lorem ipsum dolor sit amet, 
                    consectetur adipiscing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                    Ut enim ad minim veniam, 
                    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    """
            ),
            Notes(
                title: "Cara menenangkan bayi yang menangis",
                content: """
                    1. Jangan ajak bayi bermain catur karena bayi belum mengetahui peraturan catur
                    2. Tetap tenang
                    3. Apabila langkah 2 gagal, ulangi dari awal
                    4. PENTING! Bayi belum bisa memahami bagaimana menggunakan xcode, alangkah baiknya jauhkan perangkat mac dari sekitar bayi
                    """
            ),
        ]
    }
}
