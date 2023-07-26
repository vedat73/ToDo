//
//  BlankView.swift
//  ToDo
//
//  Created by Vedat Ozlu on 25.07.2023.
//

import SwiftUI

struct BlankView: View {
    // MARK: - PROPERTIES
    var backgroundColor : Color
    var backgroundOpacity : Double
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .edgesIgnoringSafeArea(.all)
        .blendMode(.overlay)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
