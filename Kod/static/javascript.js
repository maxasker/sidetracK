function showReplyBox(id,topicid,thispage,asd){
    if (asd==0) {
    
var elem = '<form id ="form1" action = "'+formLink+'" enctype="multipart/form-data" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<textarea name="text" placeholder="Title" maxlength="100" rows="5" cols="50">Title</textarea><hr><hr><input type="file" name="commentimg" accept="image/*"><input type="submit" value="Spara innehåll"></form>';
    var empty = ""; 

document.getElementById('elem').innerHTML = elem;
return false;

}
        else { 
    document.getElementById('elem').innerHTML = null;
return false;
}

}

function showReplyBox2(id,topicid,thispage,asd, currentElement){
    if (asd==0) {
        
    var mapp = currentElement.getAttribute("data-form-link");
        console.log(mapp);
    
var elem = '<form id ="form1" action = "'+mapp+'" enctype="multipart/form-data" method="post"><input type="hidden" name="comid" value="';
elem = elem+ id + '">';
elem = elem + '<textarea name="text" placeholder="Title" maxlength="100" rows="5" cols="50">Title</textarea><hr><hr><input type="file" name="commentcommentimg" accept="image/*"><input type="submit" value="Spara innehåll"></form>';
    var empty = ""; 

document.getElementById('elem').innerHTML = elem;
return false;

}
        else { 
    document.getElementById('elem').innerHTML = null;
return false;
}

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

