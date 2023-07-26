//
//  ContentView.swift
//  ToDo
//
//  Created by Vedat Ozlu on 23.07.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @State var task : String = ""
    @State private var showNewTaskItem : Bool = false
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    //FetchRequest sorting : NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],animation: .default) private var items: FetchedResults<Item>
    // MARK: - FUNCTION

    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do { 
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: -  BODY
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - MAIN VIEW
                VStack {
                    // MARK: - HEADER
                    HStack(spacing: 10) {
                        // TITLE
                        Text("ToDo")
                            .font(.system(.largeTitle,design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        Spacer()
                        
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16,weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth : 2)
                            )
                        
                        // APPEARANCE BUTTON
                        Button {
                            // TOGGLE APPEARANCE
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24,height: 24)
                                .font(.system(.title,design: .rounded))
                        }
                        
                    }//: HStack
                    .padding()
                    .foregroundColor(Color.white)
                    Spacer(minLength: 80)
                    // MARK: - NEW TASK BUTTON
                    Button {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30,weight: .bold,design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24,weight: .bold,design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color.black.opacity(0.25),radius: 8, x: 0.0, y: 0.0)
                    
                    // MARK: - TASKS
                     
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } //: List
                    .listStyle(InsetGroupedListStyle())
                    .scrollContentBackground(.hidden) // iOS 16 and above
                    .shadow(color: Color.black.opacity(0.3),radius: 12)
                    .scrollIndicators(.hidden )
                    .padding(.vertical,0)
                    .frame(maxWidth: 640) //for iPad devices
                } //: VStack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: showNewTaskItem)
                .padding()
                // MARK: - NEW TASK ITEM
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing : $showNewTaskItem)
                }
            } //: ZStack
            .onAppear(){
                UIScrollView.appearance().backgroundColor = UIColor.clear
            }
            .navigationTitle("Daily Tasks").toolbar(.hidden)
            .navigationBarTitleDisplayMode(.large)
            .background(
                BackgroundImageView()
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        } //: NavigationView
    }
}



// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
