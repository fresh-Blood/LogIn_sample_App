import Foundation
import HealthKit



final class Health {
    static let healthStore = HKHealthStore()
    
    static func getTodaySteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                    end: now,
                                                    options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepsQuantityType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, _ in
            guard
                let result = result, let sum = result.sumQuantity() else {
                    completion(0.0)
                    return
                }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        Health.healthStore.execute(query)
    }
}

extension MainViewController {
    func setHealthKitPolitics() {
        // Access stepCount
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        ]
        // Check for authorization
        Health.healthStore.requestAuthorization(toShare: healthKitTypes,
                                                read: healthKitTypes) { bool, error in
            if bool {
                // Authorization successfull
                Health.getTodaySteps { result in
                    DispatchQueue.main.async { [weak self] in
                        guard
                            let goal = (self?.ofStepslabel.text)?.chooseNumbersOnly() else { return }
                        guard
                            let goalNumber = Int(goal) else { return }
                        
                        let leftToGoInfo = goalNumber - Int(result)
                        
                        if leftToGoInfo <= 0 {
                            self?.stepsNumbers.text = String(Int(result))
                            self?.endStepsValue = String(Int(result))
                        } else {
                            self?.stepsNumbers.text = String(leftToGoInfo)
                            self?.endStepsValue = String(leftToGoInfo)
                        }
                    }
                }
            }
        }
    }
}
