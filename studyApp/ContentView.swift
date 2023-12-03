//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("studyApp")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            Spacer()
            Button(action: {
                // add action
            }) {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Start")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                }
                .frame(width: 300.0, height: 95.0)
                .background(.blue)
                .cornerRadius(20.0)
            }
            
            Button(action: {
                // add action
            }) {
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Study Types")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                }
                .frame(width: 250, height: 75)
                .background(.blue)
                .cornerRadius(20.0)
            }
            
            Button(action: {
                // add action
            }) {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Reminders")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                }
                .frame(width: 250, height: 75)
                .background(.blue)
                .cornerRadius(20.0)
            }
            
            Button(action: {
                // add action
            }) {
                HStack {
                    Image(systemName: "bubble.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Language")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                }
                .frame(width: 250, height: 75)
                .background(.blue)
                .cornerRadius(20.0)
            }
            

            Spacer()
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
