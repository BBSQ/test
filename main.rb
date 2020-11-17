require_relative 'script_status'
require_relative 'script'

url = ARGV[0] # a. ссылка на страницу категории (может передаваться любая категория сайта)
file = ARGV[1] # b. имя файла в который будет записан результат

Script.new(url,file).run
#ScriptStatus.script_end_status