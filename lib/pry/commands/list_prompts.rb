class Pry::Command::ListPrompts < Pry::ClassCommand
  match 'list-prompts'
  group 'Input and Output'
  description 'List the prompts available for use.'
  banner <<-BANNER
    Usage: list-prompts

    List the available prompts. You can use change-prompt to switch between
    them.
  BANNER

  def process
    output.puts heading("Available prompts") + "\n\n"
    all_prompts.each do |prompt|
      next if prompt.alias?
      aliases = Pry::Prompt.aliases_for(prompt.name)
      output.write "Name: #{text.bold(prompt.name)}"
      output.puts selected_prompt?(prompt) ? text.green(" [active]") : ""
      output.puts "Aliases: #{aliases.map(&:name).join(',')}" if aliases.any?
      output.puts prompt.description
      output.puts
    end
  end

  private

  def all_prompts
    Pry::Prompt.all_prompts
  end

  def selected_prompt?(prompt)
    _pry_.prompt == prompt
  end
  Pry::Commands.add_command(self)
end
