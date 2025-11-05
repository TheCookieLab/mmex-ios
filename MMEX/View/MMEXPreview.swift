import SwiftUI

@MainActor
struct MMEXPreview {
    static let pref = Preference()
    static let vmWithoutData    = ViewModel.withoutData
    static let vmWithSampleData = ViewModel.withSampleData

    @ViewBuilder
    static func appWithoutData<Content: View>(
        @ViewBuilder content: @escaping (_ pref: Preference, _ vm: ViewModel) -> Content
    ) -> some View {
        content(Self.pref, Self.vmWithoutData)
            .environmentObject(Self.pref)
            .environmentObject(Self.vmWithoutData)
    }

    @ViewBuilder
    static func appWithSampleData<Content: View>(
        @ViewBuilder content: @escaping (_ pref: Preference, _ vm: ViewModel) -> Content
    ) -> some View {
        content(Self.pref, Self.vmWithSampleData)
            .environmentObject(Self.pref)
            .environmentObject(Self.vmWithSampleData)
    }
}

extension MMEXPreview {
    @ViewBuilder
    static func tab<Content: View>(
        _ title: String,
        @ViewBuilder content: @escaping (_ pref: Preference, _ vm: ViewModel) -> Content
    ) -> some View {
        MMEXPreview.appWithSampleData { pref, vm in NavigationView {
            content(pref, vm)
                .navigationBarTitle(title, displayMode: .inline)
        } }
    }
}
