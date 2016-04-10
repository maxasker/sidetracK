function showReplyBox(id,topicid,thispage){
    
var elem = '<form id ="form1" action = "/{{threadcategori}}/{{threadname}}/savenewcomment" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<input type="hidden" name="topicid" value="';
elem = elem + topicid + '">';
elem = elem + '<input type="hidden" name="thispage" value="';
elem = elem + thispage + '">';
elem = elem + '<span>Comment</span>'
elem = elem + '<textarea name = "text" autofocus placeholder="Reply to comment" id="replyarea" rows=4 cols=52></textarea><br><label class="myLabel"><label class="myLabel"><input type="file"><span id ="uploadbutt">Choose file</span></label><input type="submit" id = "replybutt" value="save content"></form>';
    var empty = ""; 

document.getElementById('elem').innerHTML = elem;
return false;

}

function $(el){
                return document.getElementById(el);
            }
            var tzdragg = function(){
                return {
                    move : function(divid,xpos,ypos){
                        var a = $(divid);
                        $(divid).style.left = xpos + 'px';
                        $(divid).style.top = ypos + 'px';
                    },
                    startMoving : function(evt){
                        evt = evt || window.event;
                        var posX = evt.clientX,
                            posY = evt.clientY,
                            a = $('elem'),
                        divTop = a.style.top,
                        divLeft = a.style.left;
                        divTop = divTop.replace('px','');
                        divLeft = divLeft.replace('px','');
                        var diffX = posX - divLeft,
                            diffY = posY - divTop;
                        document.onmousemove = function(evt){
                            evt = evt || window.event;
                            var posX = evt.clientX,
                                posY = evt.clientY,
                                aX = posX - diffX,
                                aY = posY - diffY;
                            tzdragg.move('elem',aX,aY);
                        }
                    },
                    stopMoving : function(){
                        var a = document.createElement('script');
                        document.onmousemove = function(){}
                    },
                }
            }();

