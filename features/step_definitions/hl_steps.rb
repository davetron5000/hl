require 'rainbow'
Sickill::Rainbow.enabled = true
CONTENTS = [
  'This is the first line',
  'This is the second line and %{keyword} it contains the search term',
  'This is the last line',
]
Given /^a file named "([^"]*)" with the word "([^"]*)" in it$/ do |filename, keyword|
  @contents_without_ansi = CONTENTS.map { |line| line.gsub('%{keyword}','>>=').split('>>=') }.flatten
  @contents = CONTENTS.map { |line| line % { :keyword => keyword } }
  File.open(filename,'w') { |file| @contents.each { |_| file.puts _ } }
end

Then /^the entire contents of "([^"]*)" should be output$/ do |file|
  @contents_without_ansi.each { |_| assert_partial_output(_,all_stdout) }
end

Then /^the word "([^"]*)" should be highlighted in (.*$)$/ do |keyword,color|
  if color == 'bright inverted underlined blue'
    expected = keyword.color(:blue).inverse.bright.underline
  else
    expected = keyword.color(color.to_sym)
  end
  assert_partial_output(expected,all_stdout)
end

Then /^I type some text containing "([^"]*)"$/ do |keyword|
  @contents_without_ansi = CONTENTS.map { |line| line.gsub('%{keyword}','>>=').split('>>=') }.flatten
  contents = CONTENTS.map { |line| line % { :keyword => keyword } }
  contents.each do |line|
    step %{I type "#{line}"}
  end
  @interactive.stdin.close
end

Then /^the contents of what I typed should be output$/ do
  @contents_without_ansi.each { |_| assert_partial_output(_,all_stdout) }
end
