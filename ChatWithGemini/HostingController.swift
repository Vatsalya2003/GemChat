import SwiftUI

class HostingController: UIHostingController<ContentView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ContentView())
    }

    override init(rootView: ContentView) {
        super.init(rootView: rootView)
    }
}
