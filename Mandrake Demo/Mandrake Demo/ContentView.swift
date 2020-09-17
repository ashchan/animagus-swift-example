//
//  ContentView.swift
//  Mandrake Demo
//
//  Created by James Chen on 2020/09/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                DispatchQueue.global(qos: .userInitiated).async {
                    Animagus().test()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
