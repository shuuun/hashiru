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
    if call.method == "getWorkoutData" {
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
  
  private func readWorkoutData(result: @escaping FlutterResult) {
    let predicate = HKQuery.predicateForWorkouts(with: HKWorkoutActivityType.running)
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
    let query = HKSampleQuery(sampleType: HKSampleType.workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
      guard let workouts = samples as? [HKWorkout], error == nil else {
          return
      }
      var dict: [String: Any] = [:]
      var num = 0
      for workout in workouts {
        num += 1
        var result: [String: Any] = [:]
        result.updateValue(self.returnMonth(date: workout.startDate), forKey: "workout_month")
        result.updateValue(String(format: "%@", workout.totalDistance ?? "no data"), forKey: "total_distance")
        result.updateValue(String(workout.duration.stringFromTimeInterval()), forKey: "duration")
        dict.updateValue(result, forKey: "\(num)")
      }
      result(dict as NSDictionary)
    }
    
    self.healthKitStore.requestAuthorization(toShare: nil, read: readDataTypes) {
      (success, error) -> Void in
      if success == false { return } else {
        self.healthKitStore.execute(query)
      }
    }
  }
  
  private func returnMonth(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
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
