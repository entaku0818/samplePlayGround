
import UIKit
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedItem: Item?

    var items = [
        Item(name: "Apple"),
        Item(name: "Banana"),
        Item(name: "Cherry"),
        Item(name: "Durian"),
        Item(name: "Elderberry")
    ]

    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.contains(searchText) }
        }
    }

    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding(10)

            List(filteredItems) { item in
                Text(item.name)
                    .onTapGesture {
                        selectedItem = item
                    }
            }

            if let selectedItem = selectedItem {
                Text("Selected Item: \(selectedItem.name)")
            }
        }
    }
}


struct Item: Identifiable {
    var id = UUID()
    var name: String
}

PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView().frame(width: 375,height: 600))
