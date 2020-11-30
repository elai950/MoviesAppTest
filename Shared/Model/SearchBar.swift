//
//  SearchBar.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    
    var onCancel: () -> Void

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var onCancel: () -> ()

        init(text: Binding<String>, onCancel: @escaping () -> ()) {
            _text = text
            self.onCancel = onCancel
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty{
                self.onCancel()
            }else{
                text = searchText
            }
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onCancel: onCancel)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Movie..."
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
