import UIKit
import Flutter
import HealthKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    ensureInit(application)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  func ensureInit(_ application: UIApplication) {
    application.delegate = self
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel.init(name: "hashiru/workout", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler(self.handleMethodCall)
  }
  
  func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void {
    if call.method == "isHKAuthorized" {
      requestHKAuthorization(result: result)
    } else if call.method == "getWorkoutData" {
      readWorkoutData(result: result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
  
  let healthKitStore: HKHealthStore = HKHealthStore()
  let readDataTypes: Set<HKObjectType> = [
    HKWorkoutType.workoutType(),
    HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
  ]
  
  private func requestHKAuthorization(result: @escaping FlutterResult) -> Void {
    return self.healthKitStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: {(success, error) -> Void in
      if success {
        result(success)
      } else {
        result(false)
      }
    })
  }
  
  private func readWorkoutData(result: @escaping FlutterResult) {
    let predicate = HKQuery.predicateForWorkouts(with: HKWorkoutActivityType.running)
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
    let query = HKSampleQuery(sampleType: HKSampleType.workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
      guard let workouts = samples as? [HKWorkout], error == nil else {
          return
      }
      var dict: [Dictionary<String, Any>] = []
      for workout in workouts {
        var result: [String: Any] = [:]
        if let distance = workout.totalDistance {
          result.updateValue(String(distance.doubleValue(for: HKUnit.meter()) / 1000), forKey: "total_distance")
        }
        result.updateValue(self.returnMonth(date: workout.startDate), forKey: "workout_month")
        result.updateValue(String(workout.duration.stringFromTimeInterval()), forKey: "duration")
        dict.append(result)
      }
      result(dict as Array)
    }
    
    self.healthKitStore.execute(query)
  }
  
  private func returnMonth(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY/MM"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    let result = formatter.string(from: date)
    return result
  }
}

extension TimeInterval{
  func stringFromTimeInterval() -> String {

      let time = NSInteger(self)

      let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
      let seconds = time % 60
      let minutes = (time / 60) % 60
      let hours = (time / 3600)

      return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

  }
}
