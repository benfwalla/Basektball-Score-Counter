//
//  ContentView.swift
//  Basketball Score Counter Watch App
//
//  Created by Ben Wallace on 12/4/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    
    @State var awayPoints = 0
    @State var homePoints = 0
    @State var confettiState = 0
    
    var body: some View {
        VStack {
            PointsView(team: .away, points: $awayPoints, confettiState: $confettiState)
            PointsView(team: .home, points: $homePoints, confettiState: $confettiState)
                .foregroundColor(.green)
                
            Spacer()
            ResetView(awayScore: $awayPoints, homeScore: $homePoints)
        }
        .confettiCannon(counter: $confettiState, confettis: [.text("🏀"), .text("🏆"), .text("💪")], confettiSize: 20.0, fadesOut: false)
    }
}

// A View that represents an minus point button, the total points, and an add points
// button. In the app, there will be two of these: one for the home team and one for away
struct PointsView: View {
    var team: Team
    @Binding var points: Int
    @Binding var confettiState: Int
    
    var body: some View {
        HStack {
            subtractPoints()
            Spacer()
            Text(String(points)).font(.title).padding(.horizontal).minimumScaleFactor(0.5)
            Spacer()
            addPoints()
        }
        .padding(.vertical)
    }
    
    // A Button view that, when clicked, increments the parent PointsView's "points" var by 1
    func addPoints() -> some View {
        Button {
            points += 1
            if points == 21 {
                confettiState = 1 - confettiState
            }
        } label: {
            Image(systemName: "plus")
        }.foregroundColor(.green)
    }

    // A Button view that, when clicked, decrements the parent PointsView's "points" var by 1
    func subtractPoints() -> some View {
        Button {
            points > 0 ? points -= 1 : nil
        } label: {
            Image(systemName: "minus")
        }.foregroundColor(.red)
    }
}

// A View that resets the two given binded Int variables back to 0.
// These two binded variables are found in our main ContentView View.
struct ResetView: View {
    @Binding var awayScore: Int
    @Binding var homeScore: Int
    
    var body: some View {
        Button(role: .cancel) {
            awayScore = 0; homeScore = 0
        } label: {
            Text("Reset")
        }
    }
}

// Create an enumeration for home and away scores for easier coding in Views.
// Honestly, I don't really need it. Just for learning and using new stuff.
enum Team {
    case home
    case away
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
