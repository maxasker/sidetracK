#!/usr/bin/env python
# -*- coding: utf-8 -*-
from bottle import run, route, template, request, static_file, get, post, error
from bottle import static_file
from bottle import url
from bottle import redirect
import os
import sys
import datetime
import re
global threadlistlike
global threadlistclassified
global threadlistdislike
threadlistlike = []
threadlistclassified = []
threadlistdislike = []

@route('/')
def index():
    return template("index")

@route('/homepage')
def homepage():
    redirect('/')
    
@route('/<threadcategori>/createthread')
def threadshow(threadcategori):
    threadcategori = threadcategori
    return template("savenewthread", threadcategori=threadcategori)

@route('/<threadcategori>/thread/<threadname>')
def lookatsinglethread(threadcategori,threadname):
    singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    singlethreadinfo = open("static/threads/{1}/{0}/tsinfo.txt".format(threadname,threadcategori), "r")
    threadinfo = singlethreadinfo.read()
    singlethreadinfo.close()
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    sorted(commentlist)
    myList = os.listdir('static/threads/{1}/{0}/'.format(threadname,threadcategori))
    for myFile in myList:
        if re.match("tsimg.png", myFile):
            tsimg = myFile
        elif re.match("tsimg.jpeg", myFile):
            tsimg = myFile
        elif re.match("tsimg.jpg", myFile):
            tsimg = myFile
        elif re.match("tsimg.gif", myFile):
            tsimg = myFile
    tsimgpath = ('static/threads/{0}/{1}/{2}'.format(threadcategori,threadname,tsimg))
    return template("singlethread2",tsimg=tsimg,tsimgpath=tsimgpath, threadname=threadname, threadtext=threadtext, commentlist=commentlist,threadcategori=threadcategori,threadinfo=threadinfo)

def singlethread(threadcategori,threadname):
    singlethreadfile = open("static/threads/{1}/{0}/tstext.txt".format(threadname,threadcategori), "r")
    threadtext = singlethreadfile.read()
    singlethreadfile.close()
    commentlist = os.walk('static/threads/{1}/{0}/comments'.format(threadname,threadcategori)).next()[1]
    
@route('/threadoverview/<threadcategori>/<page>')
def threadoverview(threadcategori,page):
    if len(threadlistlike) == 0 or len(threadlistclassified) == 0 or len(threadlistdislike) == 0:
        threadlist2 = os.walk('static/threads/{0}'.format(threadcategori)).next()[1]
    else:
        mini=int(page)*10-10
        maxi=int(page)*10
        if threadcategori == "like":
            threadlist2 = threadlistlike[mini:maxi]
        elif threadcategori == "classified":
            threadlist2 = threadlistclassified[mini:maxi]
        elif threadcategori == "dislike":
            threadlist2 = threadlistdislike[mini:maxi]
    return template("threadoverview", threads=threadlist2, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/createnewcomment')
def createnewcomment(threadname,threadcategori):
    return template("commenttest", threadname=threadname, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/savenewcomment', method="POST")
def savenewcomment(threadcategori,threadname):
    counter = 1
    newpath2 = r'static/threads/{0}/{1}/comments/comment{2}'.format(threadcategori,threadname,counter)
    checkifdirexists(newpath2,counter,threadname,threadcategori)
    commenttext = request.forms.get("text")
    newpath = r'static/threads/{0}/{1}/comments/comment{2}/comment1.txt'.format(threadcategori,threadname,counter)
    checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

@route('/<threadcategori>/<threadname>/<mapp>/savenewcommentcomment', method="POST")
def savenewcommentcomment(threadcategori,threadname,mapp):
    counter = 2
    newpath = r'static/threads/{0}/{1}/comments/{2}/comment{3}.txt'.format(threadcategori,threadname,mapp,counter)
    commenttext = request.forms.get("text")
    checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp)
    
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

def createcommentimg(threadcategori,threadname,counter):
    upload = request.files.get("commentimg")
    if upload is not None:
        name, ext = os.path.splitext(upload.filename)
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            return "File extension not allowed."
        extt = str(ext)
        file_path = 'static/threads/{0}/{1}/comments/comment{2}/comment1{3}'.format(threadcategori,threadname,counter,extt)
        with open(file_path, 'wb') as open_file:
            open_file.write(upload.file.read())

def createcommentcommentimg(threadcategori,threadname,mapp,counter):
    upload = request.files.get("commentcommentimg")
    if upload is not None:
        name, ext = os.path.splitext(upload.filename)
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            return "File extension not allowed."
        extt = str(ext)
        file_path = 'static/threads/{0}/{1}/comments/{2}/comment{3}{4}'.format(threadcategori,threadname,mapp,counter,extt)
        with open(file_path, 'wb') as open_file:
            open_file.write(upload.file.read())

def checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp):
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/{0}/{1}/comments/{2}/comment{3}.txt'.format(threadcategori,threadname,mapp,counter)
        checkifcommentcommentexists(newpath,counter,commenttext,threadname,threadcategori,mapp)
    else:
        createcommentcommentfile(commenttext,threadname,newpath,counter,threadcategori,mapp)

def checkifdirexists(newpath2,counter,threadname,threadcategori):
    if not os.path.exists(newpath2):
        os.makedirs(newpath2)
    else:
        counter = counter+1
        newpath2 = r'static/threads/{0}/{1}/comments/comment{2}'.format(threadcategori,threadname,counter)
        checkifdirexists(newpath2,counter,threadname,threadcategori)

def checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori):
    if os.path.isfile(newpath):
        counter = counter + 1
        newpath = r'static/threads/{0}/{1}/comments/comment{2}/comment1.txt'.format(threadcategori,threadname,counter)
        checkifcommentexists(newpath,counter,commenttext,threadname,threadcategori)
    else:
        createcommentfile(commenttext,threadname,newpath,counter,threadcategori)

def createcommentcommentfile(commenttext,threadname,newpath,counter,threadcategori,mapp):
    newcommentfile = open("{0}".format(newpath), "w")
    date_time = datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S")
    newcommentfile.write(date_time)
    newcommentfile.write("\n"+commenttext)
    newcommentfile.close()
    if threadcategori == "like":
        threadlistlike.remove(threadname)
        threadlistlike.insert(0, threadname)
    elif threadcategori == "classified":
        threadlistclassified.remove(threadname)
        threadlistclassified.insert(0, threadname)
    elif threadcategoi == "dislike":
        threadlistdislike.remove(threadname)
        threadlistdislike.insert(0, threadname)
    createcommentcommentimg(threadcategori,threadname,mapp,counter)

def createcommentfile(commenttext,threadname,newpath,counter,threadcategori):
    newcommentfile = open("{0}".format(newpath), "w")
    date_time = datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S")
    newcommentfile.write(date_time)
    newcommentfile.write("\n"+commenttext)
    newcommentfile.close()
    if threadcategori == "like":
        threadlistlike.remove(threadname)
        threadlistlike.insert(0, threadname)
    elif threadcategori == "classified":
        threadlistclassified.remove(threadname)
        threadlistclassified.insert(0, threadname)
    elif threadcategori == "dislike":
        threadlistdislike.remove(threadname)
        threadlistdislike.insert(0, threadname)
    createcommentimg(threadcategori,threadname,counter)

@route('/savenewthread/<threadcategori>', method="POST")
def savethread(threadcategori):
    threadname = request.forms.get("title").replace(" ", "_____")
    text = request.forms.get("text")
    newpath = r'static/threads/{1}/{0}/comments'.format(threadname, threadcategori)
    newpath2 = r'static/threads/{1}/{0}'.format(threadname, threadcategori)
    if os.path.exists(newpath2):
        return "There already exists a thread with this title"
    date_time = datetime.datetime.now().strftime("%Y-%m-%d, %H:%M:%S")
    if request.files.get("tspic") is None:
        return "You need to upload a picture."
    upload = request.files.get("tspic")
    if not os.path.exists(newpath):
        os.makedirs(newpath)
    if upload is not None:
        name, ext = os.path.splitext(upload.filename)
        if ext not in ('.png','.jpg','.jpeg','.gif'):
            return "File extension not allowed."
        extt = str(ext)
        file_path = "{path}/{file}".format(path=newpath2, file="tsimg" + extt)
        with open(file_path, 'wb') as open_file:
            open_file.write(upload.file.read())
    
    savethreadfile(newpath2,threadname,text,date_time)
    if threadcategori == "like":
        threadlistlike.insert(0,threadname)
    elif threadcategori == "classified":
        threadlistclassified.insert(0,threadname)
    elif threadcategori == "dislike":
        threadlistdislike.insert(0,threadname)
    redirect('/{0}/thread/{1}'.format(threadcategori,threadname))
    return template('singlethread2', threadname=threadname, threadcategori=threadcategori)

def savethreadfile(newpath2,threadname,text,date_time):
    newthreadtitlefile = open("{0}/tstitle.txt".format(newpath2), "w")
    newthreadtitlefile.write(threadname)
    newthreadtitlefile.close()

    newthreadtextfile = open("{0}/tstext.txt".format(newpath2), "w")
    newthreadtextfile.write(text)
    newthreadtextfile.close()

    newthreadtextfile = open("{0}/tsinfo.txt".format(newpath2), "w")
    newthreadtextfile.write(date_time)
    newthreadtextfile.close()


@route('<filename:re:.*\.css>',name='static')
def css(filename):
    print "css:",filename
    return static_file(filename,root='./static',mimetype='text/css')

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static')

run(host='localhost', port=9445, debug=True, reloader=True)
