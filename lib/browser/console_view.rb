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
    results
  end

  #TODO: make this private and test through show_results
  def truncate(description, max_length=120)
    adjusted_length = max_length - 3
    if description.length > max_length
      description.match(/^.{1,#{adjusted_length}}\b/)[0].strip + '...'
    else
      description
    end
  end

  def get_result(results_count)
    @out.print "Choose a result (1 - #{results_count.to_s}): "
    user_choice = @in.gets
    user_choice.to_i - 1
  end

  def no_results(query)
    @out.puts "'#{query}' returned no results..."
  end
end
