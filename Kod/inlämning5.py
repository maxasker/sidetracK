from bottle import run, route, template, request, static_file
from os import listdir
from bottle import static_file

@route('/')
def index():
        return template("index")

@route('/static/<filename>')
def server_static(filename):
  return static_file(filename, root='/path/to/your/static/files')

run(host='localhost', port=9057, debug=True, reloader=True)
