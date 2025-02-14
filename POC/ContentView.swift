//
//  ContentView.swift
//  EyeofcloudDemo
//
//  Created by Chen Guagnghui on 2023-04-30.
//

import SwiftUI
import Eyeofcloud



//var eyeofcloud: EyeofcloudClient = initEyeOfCloud()
struct Variable: Identifiable {
    var id: String
    let value: String
}

struct ContentView: View {
        @State var eyeofcloud: EyeofcloudClient = EyeofcloudDemoApp.Variables.eyeofcloud
        // userId change
        @AppStorage("userId") var userId: String = "1"
    
        @State private var button_text: String = "编辑"
        @State private var button_color: String = "#6495ED"
        @State var color = Color.blue
    
        var body: some View {
                Button(action: {
                    SendTrack()
                }) {
                    Text(button_text)
                }.padding()
                .background(color)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            .scrollDisabled(false)
            .onAppear(perform: initBuy)
        }
    
        func initBuy() {
            let attributes = [
                "city": "南京",
                "hobby": "健身"
            ]
    
            self.eyeofcloud.start{ [self] result in
                do{
                    let user = self.eyeofcloud.createUserContext(userId: userId, attributes: attributes)
                    // flagKey change
                    let decision = user.decide(key: "xingye_shiyanyi")
                    let variableMap = decision.variables.toMap()
                    button_text = variableMap["button_text"] as! String
                    button_color = variableMap["button_color"] as! String
                    button_text = button_text != "" ? button_text : "编辑"
                    button_color = button_color != "" ? button_color : "#6495ED"
                    self.color = hexStringToUIColor(hex: button_color)
                }
            }
        }
    
        func SendTrack() {
            let eventTags: [String: Any] = ["browser": "chrome"]
            do{
                try self.eyeofcloud.track(eventKey: "dianjilv1", userId: userId, eventTags: eventTags)
            } catch {
                print(error)
            }
        }
}

func hexStringToUIColor (hex:String) -> Color {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }
    if cString.count != 6 {
        return Color.blue //默认颜色，可以根据需要设置
    }
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let b = CGFloat(rgbValue & 0x0000FF) / 255.0
    return Color(red: r, green: g, blue: b)
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        EmptyView()
    }
}
