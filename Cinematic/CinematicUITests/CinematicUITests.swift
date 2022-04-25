//
//  CinematicUITests.swift
//  CinematicUITests
//
//  Created by sagar patil on 21/04/2022.
//

import XCTest

class CinematicUITests: XCTestCase {
    
    
    // Can use use Snapshot testing tool as well
    func test_WhenSearchWithMovieName_DisplaysTheMovieDetail() {

        let movieApplication = XCUIApplication()
        movieApplication.launch()
        
        let navigationSearchBar = movieApplication.navigationBars["Movies"]
        let navigationBarSearchField = navigationSearchBar.searchFields["Search"]
        let filteredCell = movieApplication.tables.staticTexts["The Dark Knight Rises"]

        navigationSearchBar.tap()
        navigationBarSearchField.tap()
        
        navigationBarSearchField.typeText("The Dark Knight Rises")
        navigationBarSearchField.tap()
        
        XCTAssertTrue(filteredCell.exists)
    }
}
