import XCTest
@testable import LoginPageUnitTesting

final class UnitTestTests: XCTestCase {

        
        
    func testLoginSuccess() {
            let viewModel = LoginViewModel()
            let expectation = XCTestExpectation(description: "Login successful")
            
            viewModel.login(username: "atistagetest", password: "Password1")
            
            DispatchQueue.global().async {
               
                sleep(5)
               
                XCTAssertTrue(viewModel.isLoggedIn)
                

                expectation.fulfill()
            }
            

            wait(for: [expectation], timeout: 10)
        }
    
    
        
        func testLoginFailure() {
            let viewModel = LoginViewModel()
            let expectation = XCTestExpectation(description: "Login failed")
            
            viewModel.login(username: "atistagetest", password: "WrongPassword")
            
            DispatchQueue.global().async {
               
                sleep(5)
                XCTAssertFalse(viewModel.isLoggedIn)

                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 10)
        }
    }


