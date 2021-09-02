//
//  ContentView.swift
//  ReminderApp
//
//  Created by Han on 1/9/21.
//

import SwiftUI
import UserNotifications
import CoreLocation
class NotificationManager{
    static let instance = NotificationManager()
    
    func reqAuthorization(){
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) {(success, error) in
            if let error = error{
                print("Error: \(error)")
            }else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Reading Time"
        content.subtitle = "Reading for week xx is ready for you. Please go the app to read."
        content.sound = .default
        content.badge = 1
        
        //by time interval
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //by calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 30
        dateComponents.weekday = 2
        let triggerDate = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //by location
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerDate)
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct ContentView: View {
    var body: some View {
        
        VStack(spacing:40) {
            
            Button("Request Permission") {
                // first request noti permission
                NotificationManager.instance.reqAuthorization()
            }

            Button("Schedule Notification") {
                // second schedule noti
                NotificationManager.instance.scheduleNotification()
                
            }
        }
        .onAppear{
            
            //clear badge number
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
