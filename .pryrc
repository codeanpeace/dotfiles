require 'rubygems'

# Switch default editor for Pry to Vim
Pry.config.editor = 'vim'

# Debugging With Pry - binding.pry
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Aliases
Pry.commands.alias_command 'h', 'history'
Pry.commands.alias_command 'ht', 'history --tail'
Pry.commands.alias_command 'hnt', 'history -n --tail'
Pry.commands.alias_command 'hp', 'hist --replay'
Pry.commands.alias_command '@', 'whereami'
Pry.commands.alias_command 'c', 'cd'
Pry.commands.alias_command 'l', 'ls'
Pry.commands.alias_command 'pl', 'play -l'
Pry.commands.alias_command 'pi', 'play -i'
Pry.commands.alias_command 'po', 'play -o'
Pry.commands.alias_command 'ps', 'play -s'
Pry.commands.alias_command 'r', 'reload-code'
Pry.commands.alias_command 'x', 'exit'
Pry.commands.alias_command 'ep', 'exit-program'
Pry.commands.alias_command 'sm', 'show-method'
Pry.commands.alias_command 'e', 'edit'
Pry.commands.alias_command 'ec', 'edit -c'
Pry.commands.alias_command 'em', 'edit -m'

# copy helper method
def pbcopy(arg)
  out = arg.is_a?(String) ? arg : arg.inspect
  IO.popen('pbcopy', 'w') { |io| io.puts out }
  puts out
  true
end

# Pry Clipboard
begin
  require 'pry-clipboard'
  # aliases
  Pry.config.commands.alias_command 'ch', 'copy-history'
  Pry.config.commands.alias_command 'cr', 'copy-result'
rescue LoadError => e
  warn "can't load pry-clipboard"
end

# Awesome Print
begin
  require 'awesome_print'
  AwesomePrint.pry!
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
rescue LoadError => err
  puts "no awesome_print :("
end


# Hirb for Tables
begin
  require 'hirb'
  Hirb.enable
  old_print = Pry.config.print
  Pry.config.print = proc do |output, value|
    Hirb::View.view_or_page_output(value) || old_print.call(output, value)
  end
rescue LoadError => err
  puts "no hirb :("
end


# Include current object scope in prompt:
Pry.config.prompt_name = "pry@#{File.basename(Dir.pwd)}"
Pry.prompt = [
                  proc { |target_self, nest_level, pry|
                        "[#{pry.input_array.size}]\001\e[0;34m\002 #{Pry.config.prompt_name}\001\e[0m\002 (\001\e[0;33m\002#{Pry.view_clip(target_self)}\001\e[0m\002)#{":#{nest_level}" unless nest_level.zero?} ∴ "
                       },
                  proc { |target_self, nest_level, pry|
                        "[#{pry.input_array.size}]\001\e[1;34m\002 #{Pry.config.prompt_name}\001\e[0m\002(\001\e[1;33m\002#{Pry.view_clip(target_self)}\001\e[0m\002)#{":#{nest_level}" unless nest_level.zero?} * "
                       }
                  ]


# My Pry is polite
Pry.config.hooks
Pry.config.hooks.add_hook(:before_session, :say_hi) { puts "Hello!!" }
Pry.config.hooks.add_hook(:after_session, :say_bye) { puts "Tchau!!" }
