//
//  NewTaskItemView.swift
//  ToDo
//
//  Created by Vedat Ozlu on 25.07.2023.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @State var task : String = ""
    @Environment(\.managedObjectContext) private var viewContext
    private var isButtonDisabled : Bool {
        task.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    @Binding var isShowing : Bool
    // MARK: - FUNCTION
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.id = UUID()
            newItem.completion = false
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24,weight: .bold,design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                    .autocorrectionDisabled()
                
                Button {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24,weight: .bold,design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
            } //: VStack
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.65), radius: 24)
        } //: VStack
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
