//
//  FeedViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//
import Foundation
import Combine
import Habitat

final class FeedViewModel: ObservableObject {
    enum Destination {
        case createWorkout(WorkoutCreationViewModel)
        case workoutDetail(WorkoutViewModel)
        case previousSessionSummary(SummaryModel)
    }
    
    @Dependency(\.workoutsStorage)
    private var dataStorage: WorkoutsStorage
    @Dependency(\.healthStorage)
    private var healthStorage: HealthStorage
    @Dependency(\.dateHelper)
    private var dateHelper: DatesHelper
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published
    var isOnForeground = true
    
    @Published
    var destination: Destination? {
        didSet {
            bindDestination()
        }
    }
    
    @Published
    var thisWeekCardViewModel: [ThisWeekCardViewModel] = []
    
    @Published
    private var fetchedThisWeekCardViewModel: [ThisWeekCardViewModel] = []
    
    @Published
    var sessions: [WorkoutSession] = []
    
    @Published
    var workoutStatCardViewModels: [StatHighlightsCardViewModel] = []
    
    @Published
    var activityRing: [ActivityRingData] = []
    
    var sessionCards: [PreviousWorkoutCellViewModel] {
        sessions.map { PreviousWorkoutsCellViewModelFactory.build(workoutSession: $0) }
    }
    
    init(destination: Destination? = nil) {
        self.destination = destination
        setupDataStorageBindings()
        requestHealthStoreData()
        dataStorage.emitAllWorkoutSubjects()
        bindingActivityRing()
    }
    
    func createWorkoutTapped() {
        destination = .createWorkout(WorkoutCreationViewModel())
    }
    
    func workoutButtonTapped(_ workout: Workout) {
        destination = .workoutDetail(WorkoutViewModel(workout: workout))
    }
    
    func previousWorkoutButtonTapped(_ summary: SummaryModel) {
        destination = .previousSessionSummary(summary)
    }
    
    private func bindDestination() {
        guard let destination else { return }
        
        switch destination {
        case let .createWorkout(model):
            model.dismissCreation = { [weak self] in self?.destination = nil  }
        case .workoutDetail(_):
            break
        case .previousSessionSummary:
            break
        }
    }
    
    private func setupDataStorageBindings() {
        dataStorage
            .allWorkoutSubjects
            .map(FeedViewModel.fetchAllSectionsFromWorkouts)
            .assign(to: &$sessions)
        
        dataStorage
            .allWorkoutSubjects
            .map(StatHighlightCardBuilder.build)
            .assign(to: &$workoutStatCardViewModels)
        
        dataStorage
            .allWorkoutSubjects
            .map {[dateHelper] workouts in
                FeedViewModel.transformWorkoutDataIntoCards(workouts: workouts, dateHelper: dateHelper)
            }
            .assign(to: &$fetchedThisWeekCardViewModel)
        
        Publishers.CombineLatest($isOnForeground, $fetchedThisWeekCardViewModel)
            .filter { (isOnForeground, _) in
                isOnForeground
            }
            .map { (_, fetchedThisWeekCardViewModel) in
                return fetchedThisWeekCardViewModel
            }
            .assign(to: &$thisWeekCardViewModel)
    }
    
    private func requestHealthStoreData() {
        healthStorage.requestAuthorization {[weak self] sucess in
            if sucess {
                self?.bindingActivityRing()
            }
        }
        
    }
    
    private func bindingActivityRing() {
        healthStorage
            .activityRingPublisher
            .assign(to: &$activityRing)
    }
    
}

//MARK: Pure Mutations
extension FeedViewModel {
    private static func fetchAllSectionsFromWorkouts(_ workouts: [Workout]) -> [WorkoutSession] {
        var sessions = workouts.flatMap { $0.sessions }
        sessions.sort { $0.date > $1.date }
        return sessions
    }
    
    private static func transformWorkoutDataIntoCards(workouts: [Workout], dateHelper: DatesHelper) -> [ThisWeekCardViewModel] {
        let days = dateHelper.days
        let today = dateHelper.todayWeekDay
        
        var workoutGroupedByDay = workouts
            .filter { workout in workout.finalDate >= dateHelper.today }
            .flatMap { workout in
                workout
                    .daysOfTheWeek
                    .filter {$0 >= today }
                    .map { day -> (ThisWeekCardViewModel, Int) in
                        let dateString: String
                        if day == today {
                            dateString = "Today"
                        } else {
                            dateString = days[day-1]
                        }
                        
                        return (ThisWeekCardViewModel(name: workout.name, dateString: dateString, workout: workout), day)
                    }
            }
        workoutGroupedByDay.sort { $0.1 < $1.1 }
        return workoutGroupedByDay.map { $0.0 }
    }
}
