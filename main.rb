require_relative 'script'

url = ARGV[0] # a. ссылка на страницу категории (может передаваться любая категория сайта)
file = ARGV[1] # b. имя файла в который будет записан результат

ResultFileWriter.new(Script.new(url).run, file).write_to_csv