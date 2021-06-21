<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="mine_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mine Sweeper</title>
</head>
<body style=" background-color:#AAAAAA">
    <form id="form1" runat="server">
    <br />
    <br />
    <center>
        <div style="display: inline-block">
            <% draw_tb(); %>
            <div>
                <table style="width:100%; background-color:#AACCCC">
                <tr style="width:100%">
                    <td style="width:40%">
                        <center><div id="div_time">Time: 0</div></center>
                    </td>
                    <td style="width:30%">
                        <center>
                            <input id="btn_start" type="button" value="Start" onclick="javascript:init_mine();" />
                        </center>
                    </td>
                    <td style="width:40%">
                        <center><div id="div_flag">Left=--</div></center>
                    </td>
                </tr>
                </table>
            </div>
        </div>
    </center>
    </form>
</body>
<script type="text/javascript">
var x=<% get_x(); %>;
var y=<% get_y(); %>;
var m=<% get_m(); %>;
var arr;
var flag_left;
var gameover=true;
var gamestart=false;
var intervalID = setInterval(timer_tick, 1000);
var delta_t=0;
function timer_tick(){
    if(gamestart==true && gameover==false)
        delta_t=delta_t+1;
    update_time_flag();
    return ;
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}
function update_time_flag(){
    var div_t=document.getElementById("div_time");
    var div_f=document.getElementById("div_flag");
    div_f.innerHTML="Left: "+flag_left;
    div_t.innerHTML="Time: "+delta_t;
    
    
}

function check_win(){
    if(gameover) return;
    var cnt = 0;
    for (var i = 0; i < x; i++) {
        for (var j = 0; j < y; j++) {
            var box=document.getElementById("box_"+i+"_"+j);
            if (box.src.endsWith("img/box.png") || box.src.endsWith("img/flag.png")) {
                cnt++;
            }
            
        }
    }
    if (cnt==m) {
        gameover = true;
        for (var i = 0; i < x; i++) {
            for (var j = 0; j < y; j++) {
                if(arr[i][j]==9) {
                    var box=document.getElementById("box_"+i+"_"+j);
                    box.src="img/flag.png";
                }
            }
        }
        flag_left = 0;
        update_time_flag();
        alert("You win!!\n"+"Total take "+ delta_t +" seconds.\n");
    }
}

function init_mine() {
    delta_t=0;
    flag_left=m;
    update_time_flag();
    arr = new Array(x);
    var cnt=m;
    for (var i = 0; i < x; i++) {
        arr[i] = new Array(y);
        for (var j = 0; j < y; j++) {
            if(cnt>0){
                cnt--;
                arr[i][j]=9;
            } else arr[i][j]=0;
        }
    }
    for (var i = 0; i < x*y*10 ;i++) {
        var a_x = getRandomInt(x);
        var a_y = getRandomInt(y);
        var b_x = getRandomInt(x);
        var b_y = getRandomInt(y);
        var tmp;
        tmp = arr[a_x][a_y];
        arr[a_x][a_y] = arr[b_x][b_y];
        arr[b_x][b_y] = tmp;
    }
    for (var i = 0; i < x; i++) {
        for (var j = 0; j < y; j++) {
            var box=document.getElementById("box_"+i+"_"+j);
            box.src="img/box.png";
            if (arr[i][j] == 9 )continue;
            cnt=0;
            for (var di=-1;di<2;di++){
                for (var dj=-1;dj<2;dj++){
                    if(i+di>=x) continue;
                    if(i+di<0) continue;
                    if(j+dj>=y) continue;
                    if(j+dj<0) continue;
                    if(arr[i+di][j+dj] == 9)cnt++;
                }
            }
            arr[i][j] = cnt;
        }
    }
    gamestart=false;
    gameover=false;
}

init_mine();
function gg(pos_x,pos_y){
    gameover=true;
    for (var i = 0; i < x; i++) {
        for (var j = 0; j < y; j++) {
            var box=document.getElementById("box_"+i+"_"+j);
            if (arr[i][j] == 9 && box.src.endsWith("img/box.png")) {
                box.src="img/mine.png";
            }
            if (arr[i][j] != 9 && box.src.endsWith("img/flag.png")) {
                box.src="img/x.png";
            }
            
        }
    }
    alert("You lose!!");
}
function box_click(pos_x,pos_y,level){
    if(gameover) return ;
    //alert(pos_x+","+pos_y);
    var box=document.getElementById("box_"+pos_x+"_"+pos_y);
    if( ! box.src.endsWith("img/box.png") ) return;
    if(arr[pos_x][pos_y]==9) {
        if(gamestart==false){
            init_mine ();
            box_click(pos_x,pos_y,0);
            return;
        }
        box.src="img/redmine.png";
        gg();
        return;
    } else
        box.src="img/"+arr[pos_x][pos_y]+".png";
    gamestart=true;
    //alert(box.src);
    if(arr[pos_x][pos_y]==0) {
        for (var di=-1;di<2;di++){
            for (var dj=-1;dj<2;dj++){
                if(pos_x+di>=x) continue;
                if(pos_x+di<0) continue;
                if(pos_y+dj>=y) continue;
                if(pos_y+dj<0) continue;
                box_click(pos_x+di,pos_y+dj,level+1);
            }
        }
    }
    if(level==0) check_win();
}

function box_r_click(pos_x,pos_y){
    gamestart=true;
    if(gameover) return ;
    //alert(pos_x+","+pos_y);
    var box=document.getElementById("box_"+pos_x+"_"+pos_y);
    if( ! box.src.endsWith("img/box.png") && ! box.src.endsWith("img/flag.png")) return;
    if ( box.src.endsWith("img/box.png") ) {
        if(flag_left<=0) return;
        box.src="img/flag.png";
        flag_left--;
        update_time_flag();
    } else {
        box.src="img/box.png";
        flag_left++;
        update_time_flag();
    }
    
}
</script>
</html>
