Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "hl"
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version |
      |--color   |
      |-c        |
      |--bright  |
      |-b        |
      |--inverse |
      |-i        |

    And the banner should document that this app's arguments are:
      |search_term|which is required|
      |filename   |which is optional|

  Scenario: Highlights stuff in yellow by default
    Given a file named "test_file" with the word "foo" in it
    When I successfully run `hl foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in yellow

  Scenario: Highlights from stdin if no file is given
    When I run `hl foo` interactively
    And I type some text containing "foo"
    Then the contents of what I typed should be output
    But the word "foo" should be highlighted in yellow

  Scenario: Highlights stuff in blue if requested
    Given a file named "test_file" with the word "foo" in it
    When I successfully run `hl --color blue foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in blue

  Scenario: Highlights stuff in bright, inverted cyan if requested
    Given a file named "test_file" with the word "foo" in it
    When I successfully run `hl --color blue -bi foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in bright inverted blue
