$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require 'app'
run WebHookTranslator.new
