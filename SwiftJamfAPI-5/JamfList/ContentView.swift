//
//  ContentView.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-14.
//

import SwiftUI

struct ContentView: View {
  var computers = Computer.samples
  
  var body: some View {
    NavigationView {
      // first view is Master/List
      List(computers) { computer in
        NavigationLink(
          computer.general.name,
          destination: DetailView(computer: computer)
        )
      }
      // placeholder for detail view
      Text("Select an item")
        .foregroundColor(.secondary)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
