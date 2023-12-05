//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                Text("studyApp")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom, 20)
                
                Spacer()
                
                NavigationLink(destination: studyView()) {
                    mainButton(imageName: "play.fill", text: "Start")
                }
                .padding(.bottom, 20)
                
                NavigationLink(destination: settingsPage()) {
                    secondaryButton(imageName: "book.fill", text: "Study Types")
                }
                
                NavigationLink(destination: remindersView()) {
                    secondaryButton(imageName: "bell.fill", text: "Reminders")
                }
                
                Menu {
                    Text("English")
                    Text("French")
                    Text("Spanish")
                } label: {
                    secondaryButton(imageName: "bubble.fill", text: "Language")
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct mainButton: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(width: 300, height: 100)
        .background(Color.blue)
        .cornerRadius(20.0)
    }
}

struct secondaryButton: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(width: 250, height: 75)
        .background(Color.blue)
        .cornerRadius(20.0)
    }
}

struct studyView: View {
    var body: some View {
        Text("hello world! this is the study view")
    }
}

struct settingsPage: View {
    var body: some View {
        Text("hello world! this is the settings page")
    }
}

struct remindersView: View {
    var body: some View {
        Text("hello world! this is the reminders view")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
