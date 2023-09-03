import Foundation
import HealthKit
import Firebase

class HealthManager: ObservableObject {
    // Instance of HealthStore
    let healthStore = HKHealthStore()
    
    var activeEnergy: Double = 0
    var exerciseTime: Double = 0
    var standTime: Double = 0
    var hr: Double = 0
    var restinghr: Double = 0
    var walkinghr: Double = 0
    
    
    init() {
        // Check access to user data
        if(HKHealthStore.isHealthDataAvailable()) {
            // This will be all the activity stats
            let calories = HKQuantityType(.activeEnergyBurned)
            let exercise = HKQuantityType(.appleExerciseTime)
            let stand = HKQuantityType(.appleStandTime)
            
            // This will be all the health stats - Heart Based
            let heartRate = HKQuantityType(.heartRate)
            let restingHR = HKQuantityType(.restingHeartRate)
            let walkingHR = HKQuantityType(.walkingHeartRateAverage)
            
            // HealthTypes we want access to
            let healthTypes: Set = [calories, exercise, stand, heartRate, restingHR, walkingHR]
            
            Task {
                do {
                    try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                    
                    let group = DispatchGroup()
                    
                    group.enter()
                    fetchCalories {
                        group.leave()
                    }
                    
                    group.enter()
                    fetchWalkingHeartRateAverage {
                        group.leave()
                    }
                    
                    group.enter()
                    fetchStandTime {
                        group.leave()
                    }
                    
                    group.enter()
                    fetchExerciseTime {
                        group.leave()
                    }
                    
                    group.enter()
                    fetchRestingHeartRate {
                        group.leave()
                    }
                    
                    group.enter()
                    fetchWalkingHeartRateAverage {
                        group.leave()
                    }
                    
                    group.enter()
                    fetchHeartRateData {_ in
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        self.updateFirebaseDocument()
                    }
                } catch {
                    print("Error fetching data")
                }
            }
        }
    }
    
    func fetchHeartRateData(completion: @escaping (Double) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
            guard let result = result, let averageHeartRate = result.averageQuantity() else {
                if let error = error {
                    print("Error fetching heart rate data: \(error.localizedDescription)")
                }
                completion(0)
                return
            }
            
            let bpm = averageHeartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            completion(bpm)
            self.hr = bpm
        }
        
        healthStore.execute(query)
    }
    
    func fetchCalories(completion: @escaping () -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {_, res, err in
            guard let amount = res?.sumQuantity(), err == nil else {
                print("Error fetching today's calories: \(err?.localizedDescription ?? "")")
                self.activeEnergy = 0
                completion()
                return
            }
            
            self.activeEnergy = amount.doubleValue(for: .kilocalorie())
            completion()
        }
        
        healthStore.execute(query)
    }
    
    func fetchExerciseTime(completion: @escaping () -> Void) {
        let exerciseTime = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: exerciseTime, quantitySamplePredicate: predicate) { _, result, error in
            guard let time = result?.sumQuantity(), error == nil else {
                print("Error fetching exercise time: \(error?.localizedDescription ?? "")")
                self.exerciseTime = 0
                completion()
                return
            }
            
            let minutes = time.doubleValue(for: .minute())
            self.exerciseTime = minutes
            completion()
        }
        
        healthStore.execute(query)
    }
    
    func fetchStandTime(completion: @escaping () -> Void) {
        let standTime = HKQuantityType(.appleStandTime)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: standTime, quantitySamplePredicate: predicate) { _, result, error in
            guard let time = result?.sumQuantity(), error == nil else {
                print("Error fetching stand time: \(error?.localizedDescription ?? "")")
                self.standTime = 0
                completion()
                return
            }
            
            let minutes = time.doubleValue(for: .minute())
            print("Stand time today (minutes): \(minutes)")
            self.standTime = minutes
            completion()
        }
        
        healthStore.execute(query)
    }
    
    func fetchRestingHeartRate(completion: @escaping () -> Void) {
        let restingHRType = HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: restingHRType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
            guard let result = result, let averageRestingHR = result.averageQuantity() else {
                if let error = error {
                    print("Error fetching resting heart rate data: \(error.localizedDescription)")
                }
                completion()
                return
            }
            
            let bpm = averageRestingHR.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            self.restinghr = bpm
            completion()
        }
        
        healthStore.execute(query)
    }
    
    func fetchWalkingHeartRateAverage(completion: @escaping () -> Void) {
        let walkingHRType = HKQuantityType.quantityType(forIdentifier: .walkingHeartRateAverage)!
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: walkingHRType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
            guard let result = result, let averageWalkingHR = result.averageQuantity() else {
                if let error = error {
                    print("Error fetching walking heart rate average data: \(error.localizedDescription)")
                }
                completion()
                return
            }
            
            let bpm = averageWalkingHR.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            self.walkinghr = bpm
            completion()
        }
        
        healthStore.execute(query)
    }
    
    func updateFirebaseDocument() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        
        userRef.updateData([
            "activeEnergy": activeEnergy,
            "exerciseTime": exerciseTime,
            "standTime": standTime,
            "hr": hr,
            "restinghr": restinghr,
            "walkinghr": walkinghr,
            "time": Date()
        ]) { error in
            if let error = error {
                print("Error updating Firebase document: \(error.localizedDescription)")
            } else {
                print("Firebase document updated successfully.")
            }
        }
    }
}
