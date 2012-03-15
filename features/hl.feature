Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "hl"
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options

    And the banner should document that this app's arguments are:
      |search_term|which is optional|
      |filename   |which is optional|

  Scenario: Highlights stuff in yellow by default
    Given a file named "test_file" with the word "foo" in it
    When I successfully run `hl foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in yellow

  Scenario: Highlights the pattern used in the flag
    Given a file named "test_file" with the word "foo" in it
    When I successfully run `hl --regexp=foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in yellow

  Scenario: Highlights multiple times per line if needed
    Given a file named "test_file" with the word "foo bar foo" in it
    When I successfully run `hl foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted both times in yellow

  Scenario: Highlights with case insensitivity
    Given a file named "test_file" with the word "FOO bar foo" in it
    When I successfully run `hl -i foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in yellow
    And the word "FOO" should be highlighted in yellow

  Scenario Outline: Treats search term as a regexp
    Given a file named "test_file" with the word "867-5309" in it
    When I successfully run `hl <term> ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "867-5309" should be highlighted in yellow

    Examples:
      |term|
      |'867-\d\d\d\d'|
      |--regexp='867-\d\d\d\d'|

  Scenario: It is an error to omit both the search term and the --regexp flag
    When I run `hl`
    Then the stderr should contain "search term or --regexp/-p required"

  Scenario: Highlights stuff in yellow by default using multiple files
    Given a file named "test_file" with the word "foo" in it
    And a file named "test_file2" with the word "foobar" in it
    When I successfully run `hl foo ../../test_file ../../test_file2`
    Then the entire contents of "test_file" should be output
    Then the entire contents of "test_file2" should be output
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

  Scenario: Highlights stuff in bright, inverted, underlined cyan if requested
    Given a file named "test_file" with the word "foo" in it
    When I successfully run `hl --color blue -bun foo ../../test_file`
    Then the entire contents of "test_file" should be output
    But the word "foo" should be highlighted in bright inverted underlined blue
