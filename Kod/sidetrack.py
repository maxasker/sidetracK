from bottle import run, route, template, request, static_file
from os import listdir
from bottle import static_file
from bottle import url

@route('/')
def index():
        return template("index")

@route('/threadshow')
def threadshow():
    return template("thread")


@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

run(host='localhost', port=9057, debug=True, reloader=True)
