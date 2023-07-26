//
//  BackgroundImageView.swift
//  ToDo
//
//  Created by Vedat Ozlu on 25.07.2023.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .resizable()
            .antialiased(true)
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
