//
//  FlowTest.swift
//  GameEngineTests
//
//  Created by Ibrahim Hosseini on 4/27/22.
//

import XCTest

@testable import GameEngine

class FlowTest: XCTestCase {

  func test_startWithNoQuestion_doesNotRouteToQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: [], router: router)

    sut.start()

    XCTAssertTrue(router.routedQuestions.isEmpty)
  }

  func test_startWithOneQuestion_routeToCorrectQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1"], router: router)

    sut.start()

    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }

  func test_startWithOneQuestion_routeToCorrectQuestion_2() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q2"], router: router)

    sut.start()

    XCTAssertEqual(router.routedQuestions, ["Q2"])
  }

  func test_startWithTwoQuestion_routeToFirstQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1", "Q2"], router: router)

    sut.start()

    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }

  func test_startTwiceTwoQuestion_routeToFirstQuestionTwice() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1", "Q2"], router: router)

    sut.start()
    sut.start()

    XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
  }

  func test_startAndAnswerFirstQuestion_withTwoQuestions_routeToSecondQuestion() {
    let router = RouterSpy()
    let sut = Flow(questions: ["Q1", "Q2"], router: router)
    sut.start()

    router.answerCallback("A1")

    XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
  }

  class RouterSpy: Router {
    var routedQuestions: [String] = []
    var answerCallback: ((String) -> Void) = { _ in }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
      routedQuestions.append(question)
      self.answerCallback = answerCallback
    }
  }
}
