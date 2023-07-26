//
//  ListRowItemView.swift
//  ToDo
//
//  Created by Vedat Ozlu on 26.07.2023.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item : Item
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2,design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default, value:item.task)
        }//: Toggle
        .toggleStyle(CheckboxStyle())
        // item.objectWillChange is a publisher that can be subscribe to. After making change in the viewContext, we will be saving it to disk
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

//struct ListRowItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRowItemView()
//    }
//}
