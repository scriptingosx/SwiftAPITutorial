//
//  ContentView.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-14.
//

import SwiftUI

struct ContentView: View {
  @StateObject var controller = JamfController()
  
  var body: some View {
    NavigationView {
      if controller.isLoading {
        VStack {
          ProgressView().progressViewStyle(.circular)
          Text("Loading…").foregroundColor(Color.gray)
        }
      } else {
        List(controller.computers) { item in
          NavigationLink(item.general.name, destination: DetailView(computer: item))
        }
      }
      // placeholder view for detail
      Text("Select an Item")
        .foregroundColor(Color.gray)
    }
    .sheet(isPresented: $controller.needsCredentials) {
      ConnectSheet(
        show: $controller.needsCredentials,
        controller: controller
      )
    }
    .onAppear {
      Task {
        await controller.load()
      }
    }
    .toolbar(id: "Main") {
      ToolbarItem(id: "Error") {
        if controller.hasError {
          Image(systemName:  "exclamationmark.triangle.fill")
            .foregroundStyle(.secondary, .yellow)
            .imageScale(.large)
        }
      }
      ToolbarItem(id: "Connect") {
        Button(action: {
          controller.needsCredentials = true
        }) {
          Label("Connect", systemImage: controller.connected ? "bolt.horizontal.fill" : "bolt.horizontal")
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
