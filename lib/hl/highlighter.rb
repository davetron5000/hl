require 'rainbow'
module Hl
  class Highlighter
    # options - a Hash of symbols to values:
    #           :color - color to highlight
    #           :bright - highlight in bright
    #           :underline - underline highlight
    #           :inverse - invert highlight
    #           'ignore-case' - ignore case when matching
    def initialize(options)
      @options = options
    end

    # Highlights ARGF's contents, outputing each line as it comes in
    def highlight(keyword)
      Sickill::Rainbow.enabled = true
      regexp = Regexp.new(keyword,@options['ignore-case'] ? Regexp::IGNORECASE : nil)
      ARGF.lines.each do |line|
        puts highlight_matches(regexp,line)
      end
    end

  private

    def highlight_matches(regexp,rest_of_string)
      match_data = regexp.match(rest_of_string)
      return rest_of_string if match_data.nil?

      before_match = rest_of_string[0..match_data.begin(0)-1]
      after_match = rest_of_string[match_data.end(0)..-1]

      return before_match + highlight_string(match_data[0]) + highlight_matches(regexp,after_match)
    end

    def highlight_string(string)
      string = string.color(@options['color'].to_sym)
      string = string.inverse if @options[:inverse]
      string = string.bright if @options[:bright]
      string = string.underline if @options[:underline]
      string
    end

  end
end
