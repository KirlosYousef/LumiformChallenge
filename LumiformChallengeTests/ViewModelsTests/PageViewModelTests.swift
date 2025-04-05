//
//  PageViewModelTests.swift
//  LumiformChallenge
//
//  Created by Kirlos Yousef on 03/04/2025.
//

import Testing
@testable import LumiformChallenge

@Suite("Page view model tests") struct PageViewModelTests {
    struct SuccessTests {
        @Test("Test successful page data loading") func successfulPageDataLoading() async {
            // Arrange
            let mockPage = MockPage.valid
            let mockNetwork = MockNetworkService(response: mockPage)
            let vm = await PageViewModel(networkService: mockNetwork)
            
            // Act
            await vm.loadData()
            
            // Assert
            await #expect(vm.isLoading == false)
//            await #expect(vm.page?.id == mockPage.id)
        }
        
        @Test("Test loading state during fetch") func loadingStateDuringFetch() async {
            // Arrange
            let delayedNetwork = MockDelayedNetworkService(delay: 1)
            let vm = await PageViewModel(networkService: delayedNetwork)
            
            // Act
            let loadTask = Task {
                await vm.loadData()
                
                // Assert during loading
                async #expect(vm.isLoading == true)
            }
            
            // Assert
            await loadTask.value
            await #expect(vm.isLoading == false)
        }
    }
    
    struct FailureTests {
        @Test("Test error message on failure") func errorMessageOnFailure() async {
            // Arrange
            let failureNetwork = MockFailureNetworkService()
            let vm = await PageViewModel(networkService: failureNetwork)
            
            //Act
            await vm.loadData()
            
            // Assert
            await #expect(vm.errorMessage != nil)
            await #expect(vm.hasError == true)
        }
    }
}
