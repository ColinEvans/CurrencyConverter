//
//  AvailableCurrenciesProvider.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation
import Combine

final class AvailableCurrenciesProvider: AvailableCurrenciesProviding {
  let currencies = CurrentValueSubject<[Currency], Never>([])

  private let timingActor = AvailableCurrenciesTimingActor()
  private let openExchangeCurrencyProvider: any HTTPRequestProviding

  init(openExchangeCurrencyProvider: some HTTPRequestProviding) {
    self.openExchangeCurrencyProvider = openExchangeCurrencyProvider
  }
  
  func refreshCurrencies() async throws {
    guard await !timingActor.isTimerActive else {
      throw CurrencyError.notEnoughTime
    }
    
    do {
      let currencies = try await openExchangeCurrencyProvider.getLatestExchangeRates()
      self.currencies.send(currencies)
      await timingActor.startTimer()
    } catch {
      throw error
    }
  }
  
  func checkRefreshTimeInSeconds() async -> TimeInterval? {
    await timingActor.getRemainingTimeInSeconds()
  }
}

// MARK: - Extensions: Actor Definition
private extension AvailableCurrenciesProvider {
  /// Concurrency mechanism to check the remaining time limit of the API
  actor AvailableCurrenciesTimingActor {
    /// Whether or not the current timer for the api refresh is valid
    var isTimerActive = false

    private var timer: Timer?
    private let timerDurationInMinutes: Double = 30
    
    /// Starts a timer of length `timerDurationInMinutes` representing when the api is available to be called
    func startTimer() {
      guard timer == nil else {
        return
      }
      
      timer = Timer(
        timeInterval: timerDurationInMinutes * 60,
        repeats: false
      ) { [weak self] _ in
        guard let self = self else { return }
        Task {
          await self.resetTimer()
        }
      }
      isTimerActive = true
    }

    /// Resets the timer back to `nil`
    func resetTimer() {
      timer = nil
      isTimerActive = false
    }
    
    /// Checks the time since the last request to the api
    ///
    /// - Returns: The remaining time in seconds if the api is unavailable and `nil` otherwise
    func getRemainingTimeInSeconds() -> TimeInterval? {
      guard let startTime = timer?.fireDate else {
        return nil
      }

      let currentTime = Date.now
      return startTime.timeIntervalSince(currentTime)
    }
  }
}
