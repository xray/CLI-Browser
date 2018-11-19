class ConsoleView
  def initialize(input, output)
    @in = input
    @out = output
  end

  def get_search()
    @out.print 'Enter a search term: '
    @in.gets
  end

  def show_results(results)
    results_number = 0
    @out.puts ''
    results.each do |result|
      results_number += 1
      truncated_description = truncate(result.description)
      @out.puts "   ┃ \033[1m#{result.title}\033[0m"
      if results_number < 10
        @out.puts " #{results_number} ┃ #{truncated_description}"
      else
        @out.puts "#{results_number} ┃ #{truncated_description}"
      end
      @out.puts "   ┃ \e[4m#{result.url}\e[0m"
      @out.puts ''
    end
  end

  def truncate(description, max_length=120)
    adjusted_length = max_length - 3
    if description.length > max_length
      description.match(/^.{1,#{adjusted_length}}\b/)[0].strip + '...'
    else
      description
    end
  end
end
