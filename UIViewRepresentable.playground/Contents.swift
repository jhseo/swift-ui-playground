import SwiftUI

// UIViewRepresentable
// SwiftUI에서 UIKit 뷰와 뷰컨트롤러를 표현하기 위해서 사용하는 프로토콜
// - makeUIView : UIView를 생성하고 초기화를 수행
// - updateUIView : View의 업데이트가 필요할 때 호출
// - Coordinator : UIKit 뷰의 Delegate로 작동하도록 설계됨

struct SearchBar: UIViewRepresentable {
    var placeHolder: String = ""
    @Binding var searchText: String

    // UIView를 생성하고 초기화를 수행
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeHolder
        return searchBar
    }

    // View의 업데이트가 필요할 때 호출
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = searchText
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(placeHolder: placeHolder, text: $searchText)
    }

    // UISearchBarDelegate를 사용하기 위한 Coordinator
    class Coordinator: NSObject, UISearchBarDelegate {
        var placeHolder: String = ""
        @Binding var text: String

        init(placeHolder: String, text: Binding<String>) {
            self._text = text
            self.placeHolder = placeHolder
        }

        // UISearchBarDelegate
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}
