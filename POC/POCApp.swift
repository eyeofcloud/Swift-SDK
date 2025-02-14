//
//  EyeofcloudDemoApp.swift
//  EyeofcloudDemo
//
//  Created by Chen Guagnghui on 2023-04-30.
//

import SwiftUI
import Eyeofcloud

func initEyeOfCloud() -> EyeofcloudClient {
    //SDK change
    @AppStorage("sdkKey") var sdkKey = "21_05f247c0c3c80d0c"
    //datafile path change
    @AppStorage("datafileHost") var datafileHost = "http://116.198.11.124:8010"
    //event path change
    @AppStorage("eventHost") var eventHost = "http://116.198.11.124:8020"
    var datafileHandler = DefaultDatafileHandler()
    datafileHandler.endPointStringFormat = datafileHost + "/datafiles/%@.json"
    var eventURL = (eventHost != "" ? eventHost : "http://116.198.11.124:8020") + "/v1/events"
    EventForDispatch.eventEndpoint = eventURL
    
    return EyeofcloudClient(sdkKey: sdkKey, datafileHandler: datafileHandler, eventURL: URL(string: eventURL))
}


@main
struct EyeofcloudDemoApp: App {
    struct Variables {
        static var eyeofcloud: EyeofcloudClient = initEyeOfCloud()    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
