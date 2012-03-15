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

    # Returns a string containing the highlighted text from the given files or
    # STDIN if filenames is empty
    def highlight(filenames,keyword)
      Sickill::Rainbow.enabled = true
      files = if filenames.empty?
                [STDIN]
              else
                filenames.map { |_| File.open(_) }
              end
      begin

        regexp = Regexp.new(keyword,@options['ignore-case'] ? Regexp::IGNORECASE : nil)

        files.map { |_| _.readlines}.flatten.map { |_| highlight_matches(regexp,_) }.join("\n")
      ensure
        files && files.map(&:close)
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
