//
//  AppDelegate.swift
//  OurApp
//
//  Copyright © 2021 Minning. All rights reserved.
//

import CoreData
import DesignSystem
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    let appDIContainer = AppDIContainer()
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDKCommon.initSDK(appKey: "a48aa63d7b0c956c19683ef43e633aac")
//        UserApi.shared.logout(completion: { (error) in
//            
//        })
        
        let navigationController = UINavigationController(navigationBarClass: PlainUINavigationBar.self,
                                                          toolbarClass: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = .primaryBlack
        window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController,
                                        appDIContainer: appDIContainer)
        appCoordinator?.gotoSplash()
        
        if #available(iOS 13.0, *) {
            let newAppearance = UINavigationBarAppearance()
            newAppearance.configureWithOpaqueBackground()
            newAppearance.backgroundColor = .primaryBlack
            newAppearance.titleTextAttributes = [.foregroundColor: UIColor.primaryWhite]
            
            UINavigationBar.appearance().standardAppearance = newAppearance
        }
        
        window?.makeKeyAndVisible()
        
        // MARK: - Notification 푸시 알림 설정
        notificationCenter.delegate = self
        
        notificationCenter.requestAuthorization(options: [.alert]) { didAllow, error in
            if !didAllow {
                print("❗️User denied notifications request, \(String(describing: error))")
            }
        }
        
        sendNotification(hour: 18, minute: 22, category: NotificationModel.Category.routineAlert)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    func sendNotification(hour: Int, minute: Int, category: NotificationModel.Category) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "노티 타이틀"
        notificationContent.body = "노티 내용"
        
        var date = DateComponents()
        date.hour = hour
        date.minute = minute
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "\(category)", content: notificationContent, trigger: trigger)
        let identifier = "Local Notification"
        
        notificationCenter.add(request) { error in
            if error != nil {
                print("❗️Error occurs while adding notification request, \(String(describing: error))")
            }
        }
        
    }
}
