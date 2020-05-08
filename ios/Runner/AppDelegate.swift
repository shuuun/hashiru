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
    let channel = FlutterMethodChannel.init(name: "hashiru", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler(self.handleMethodCall)
  }
  
  func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void {
    if call.method == "getWorkoutData" {
      readWorkoutData()
    }
  }
  
  let healthKitStore: HKHealthStore = HKHealthStore()
  var workouts: [HKWorkout] = []
  let readDataTypes: Set<HKObjectType> = [
    HKWorkoutType.workoutType(),
    HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
  ]
  
  private func readWorkoutData() {
    let predicate = HKQuery.predicateForWorkouts(with: HKWorkoutActivityType.running)
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
    let query = HKSampleQuery(sampleType: HKSampleType.workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [unowned self] (query, samples, error) in
        guard let workouts = samples as? [HKWorkout], error == nil else {
            return
        }
        self.workouts = workouts
    }
    
    self.healthKitStore.requestAuthorization(toShare: nil, read: readDataTypes) {
      (success, error) -> Void in
      if success == false { return } else {
        self.healthKitStore.execute(query)
      }
    }
    
    for workout in self.workouts {
      print(workout.totalDistance ?? "no data")
    }
  }
}
