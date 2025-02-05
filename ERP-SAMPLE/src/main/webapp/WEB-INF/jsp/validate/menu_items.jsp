
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.sql.*,  MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<html xmlns="" lang="en" xml:lang="en"><head>
<title></title>
<link href="css/style11.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/rightclick.js"></script>
<style type="text/css">
/*!!!!!!!!!!! QuickMenu Core CSS [Do Not Modify!] !!!!!!!!!!!!!*/
.qmmc .qmdivider{display:block;font-size:1px;border-width:0px;border-style:solid;position:relative;z-index:1;}.qmmc .qmdividery{float:left;width:0px;}.qmmc .qmtitle{display:block;cursor:default;white-space:nowrap;position:relative;z-index:1;}.qmclear {font-size:1px;height:0px;width:0px;clear:left;line-height:0px;display:block;float:none !important;}.qmmc {position:relative;zoom:1;z-index:10;}.qmmc a, .qmmc li {float:left;display:block;white-space:nowrap;position:relative;z-index:1;}.qmmc div a, .qmmc ul a, .qmmc ul li {float:none;}.qmsh div a {float:left;}.qmmc div{visibility:hidden;position:absolute;}.qmmc .qmcbox{cursor:default;display:inline-block;position:relative;z-index:1;}.qmmc .qmcbox a{display:inline;}.qmmc .qmcbox div{float:none;position:static;visibility:inherit;left:auto;}.qmmc li {z-index:auto;}.qmmc ul {left:-10000px;position:absolute;z-index:10;}.qmmc, .qmmc ul {list-style:none;padding:0px;margin:0px;}.qmmc li a {float:none;}.qmmc li:hover>ul{left:auto;}#qm0 li, #qm0 a {float:none;}#qm0 li:hover>ul{top:0px;left:100%;}
/*!!!!!!!!!!! QuickMenu Styles [Please Modify!] !!!!!!!!!!!*/
/* QuickMenu 0 */
    /*"""""""" (MAIN) Container""""""""*/   
    #qm0   
    {   
        width:268px;
        background-color:transparent;
        border-width:0px 0px 0px 0px;
    }
/*"""""""" (MAIN) Items""""""""*/   
    #qm0 a   
    {   
        padding:5px 5px 5px 8px;
        margin:0px;
        background-color:#F1F1F1;
		background-image:url("qmimages/gradient_10.gif");
		background-size: cover;
		color:white;
		font-family:Bookman Old Style;
		font-size:10px;
		font-weight:bold;
        text-decoration:none;
        text-align:left;
        border-width:0px 0px 0px 0px;
        border-style:solid;
        border-color:#306FBC;
    }
/*"""""""" (MAIN) Hover State""""""""*/   
    #qm0 a:hover   
    {   
        background-image:url("qmimages/gradient_4.jpg");
    }
/*"""""""" (MAIN) Hover State - (duplicated for pure CSS)""""""""*/   
    #qm0 li:hover>a   
    {   
        text-decoration:underline;
    }
/*"""""""" (MAIN) Active State""""""""*/   
    body #qm0 .qmactive, body #qm0 .qmactive:hover   
    {   
        background-image:url("qmimages/gradient_4.jpg");
    }
/*"""""""" (SUB) Container""""""""*/   
    #qm0 div, #qm0 ul   
    {   
        padding:0px 0px 0px 0px;
		margin:0px 0px 0px 5px;
		background-color:#990000;
		border-width:1px;
		border-style:none;
    }
/*"""""""" (SUB) Items""""""""*/   
    #qm0 div a, #qm0 ul a   
    {   
        padding:3px 0px 3px 7px;
        margin:0px 0px 0px 5px;
        background-color:#F1F1F1;
        background-image:none;
        font-size:9px;
        border-width:1px;
        border-style:solid;
        border-color:#F1F1F1;
        background-image:url(qmimages/gradient_12.gif);
    }
/*"""""""" (SUB) Active State""""""""*/   
    body #qm0 div .qmactive, body #qm0 div .qmactive:hover   
    {   
        background-image:url("qmimages/gradient_4.jpg");
    }
/*"""""""" Individual Titles""""""""*/   
    #qm0 .qmtitle   
    {   
        cursor:default;
        padding:3px 0px 3px 12px;
        color:#444444;
        font-family:arial;
        font-size:11px;
        font-weight:bold;
    }
/*"""""""" Individual Horizontal Dividers""""""""*/   
    #qm0 .qmdividerx   
    {   
        border-top-width:1px;
        margin:4px 0px 4px 0px;
        border-color:#BFBFBF;
    }
/*"""""""" Individual Vertical Dividers""""""""*/   
    #qm0 .qmdividery   
    {   
        border-left-width:1px;
        height:15px;
        margin:4px 2px 0px 2px;
        border-color:#BFBFBF;
    }
/*"""""""" Box Animation Styles""""""""*/   
    #qm0 .qmbox   
    {   
        border-width:1px;
        border-style:solid;
        border-color:#999999;
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 ul li:hover > a.qmparent   
    {   
        background-image:url(symbol_9.gif);
        color:#F1F1F1;
        font-family:Verdana;
        font-weight:bold;
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 ul .qmparent   
    {   
        background-image:url(symbol_3.gif);
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 li:hover > a.qmparent   
    {   
        background-image:url(symbol_2.gif);
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 .qmparent   
    {   
        background-image:url(symbol_0.gif);
        background-repeat:no-repeat;
        background-position:95% 55%;
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 ul a   
    {   
        padding:2px 20px 2px 5px;
        background-color:#F1F1F1;
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 ul   
    {   
        background-color:#F1F1F1;
        border-width:1px;
        border-style:solid;
        border-color:#666666;
    }
/*"""""""" Custom Rule""""""""*/   
    ul#qm0 a   
    {   
        background-color:#DDDDDD;
    }
</style>
<style type="text/css">
        /* Sidebar styling */
        .sidebar {
			margin-top: 16%;
            width: 268px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background-color: #333;
            color: white;
            overflow-x: hidden;
            transition: width 0.3s;
        }

        /* Collapsed sidebar */
        .sidebar.collapsed {
            width: 0px;
        }

		.closebtn {
		         	background-image:url("imagesnew/close.gif");
			background-size: 28px 26px;
						background-repeat: no-repeat;
			background-position-y: center;
			background-position-x: 98%;
		}

        /* Toggle button styling */
        .toggle-btn {
         	background-image:url("imagesnew/close.gif");
			background-size: 28px 26px;
			background-repeat: no-repeat;
			background-position-y: center;
			background-position-x: 98%;
			/* background-size: contain; */
           	/* background-color: #17B8A2; */
           	background-color: #444;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            padding: 10px;
            width: 100%;
            text-align: left;
        }

        /* Sidebar link styling */
        .sidebar a {
            display: block;
            padding: 10px;
            color: white;
            text-decoration: none;
        }

        .sidebar a:hover {
            background-color: #575757;
        }

        /* Submenu styling */
        .submenu {
            display: none;
            padding-left: 20px;
        }

        .submenu.show {
            display: block;
        }

        /* Hide submenu text when sidebar is collapsed */
        .sidebar.collapsed .submenu {
            display: none;
        }

        /* Hide full link text in collapsed mode */
        .sidebar.collapsed ul li a:not(.toggle-btn) {
            display: block;
            text-align: center;
            padding: 10px 0;
        }

        /* Hide text within submenu items in collapsed mode */
        .sidebar.collapsed .submenu a {
            display: none;
        }
        
        #main {
  transition: margin-left .5s;
  padding: 16px;
}
.openbtn {
  font-size: 20px;
  cursor: pointer;
  background-color: #333;
  color: white;
  padding: 10px 15px;
  border: none;
}

.openbtn:hover {
  background-color: #444;
}
    </style>

<!-- Add-On Core Code (Remove when not using any add-on's) -->
<style type="text/css">.qmfv{visibility:visible !important;}.qmfh{visibility:hidden !important;}</style><script type="text/javascript">if (!window.qmad){qmad=new Object();qmad.binit="";qmad.bvis="";qmad.bhide="";}</script>
<!-- Add-On Settings -->
<script type="text/JavaScript">
/*******  Menu 0 Add-On Settings *******/
        var a = qmad.qm0 = new Object();
1        // Item Bullets Add On
		a.ibullets_apply_to = "parent";
		a.ibullets_main_image = "qmimages/symbol_0.gif";
		a.ibullets_main_image_hover = "qmimages/symbol_1.gif";
		a.ibullets_main_image_active = "qmimages/symbol_2.gif";
		a.ibullets_main_image_width = 11;
		a.ibullets_main_image_height = 11;
		a.ibullets_main_position_x = -15;
		a.ibullets_main_position_y = -6;
		a.ibullets_main_align_x = "right";
		a.ibullets_main_align_y = "middle";
		a.ibullets_sub_image = "qmimages/arrow_7.gif";
		a.ibullets_sub_image_hover = "qmimages/arrow_7.gif";
		a.ibullets_sub_image_active = "qmimages/arrow_7.gif";
		a.ibullets_sub_image_width = 5;
		a.ibullets_sub_image_height = 5;
		a.ibullets_sub_position_x = -10;
		a.ibullets_sub_position_y = -3;
		a.ibullets_sub_align_x = "left";
		a.ibullets_sub_align_y = "middle";

        // Tree Menu Add On
		a.tree_enabled = true;
		a.tree_sub_sub_indent = 15;
		a.tree_hide_focus_box = true;
		a.tree_auto_collapse = true;
		a.tree_expand_animation = 2;
		a.tree_expand_step_size = 15;
		a.tree_collapse_animation = 3;
		a.tree_collapse_step_size = 20;
</script>
<!-- Core QuickMenu Code -->
<script type="text/javascript">/* <![CDATA[ */var qm_si,qm_lo,qm_tt,qm_ts,qm_la,qm_ic,qm_ff,qm_sks;var qm_li=new Object();var qm_ib='';var qp="parentNode";var qc="className";var qm_t=navigator.userAgent;var qm_o=qm_t.indexOf("Opera")+1;var qm_s=qm_t.indexOf("afari")+1;var qm_s2=qm_s&&qm_t.indexOf("ersion/2")+1;var qm_s3=qm_s&&qm_t.indexOf("ersion/3")+1;var qm_n=qm_t.indexOf("Netscape")+1;var qm_v=parseFloat(navigator.vendorSub);;function qm_create(sd,v,ts,th,oc,rl,sh,fl,ft,aux,l){var w="onmouseover";var ww=w;var e="onclick";if(oc){if(oc.indexOf("all")+1||(oc=="lev2"&&l>=2)){w=e;ts=0;}if(oc.indexOf("all")+1||oc=="main"){ww=e;th=0;}}if(!l){l=1;sd=document.getElementById("qm"+sd);if(window.qm_pure)sd=qm_pure(sd);sd[w]=function(e){try{qm_kille(e)}catch(e){}};if(oc!="all-always-open")document[ww]=qm_bo;if(oc=="main"){qm_ib+=sd.id;sd[e]=function(event){qm_ic=true;qm_oo(new Object(),qm_la,1);qm_kille(event)};}sd.style.zoom=1;if(sh)x2("qmsh",sd,1);if(!v)sd.ch=1;}else  if(sh)sd.ch=1;if(oc)sd.oc=oc;if(sh)sd.sh=1;if(fl)sd.fl=1;if(ft)sd.ft=1;if(rl)sd.rl=1;sd.th=th;sd.style.zIndex=l+""+1;var lsp;var sp=sd.childNodes;for(var i=0;i<sp.length;i++){var b=sp[i];if(b.tagName=="A"){lsp=b;b[w]=qm_oo;if(w==e)b.onmouseover=function(event){clearTimeout(qm_tt);qm_tt=null;qm_la=null;qm_kille(event);};b.qmts=ts;if(l==1&&v){b.style.styleFloat="none";b.style.cssFloat="none";}}else  if(b.tagName=="DIV"){if(window.showHelp&&!window.XMLHttpRequest)sp[i].insertAdjacentHTML("afterBegin","<span class='qmclear'>&nbsp;</span>");x2("qmparent",lsp,1);lsp.cdiv=b;b.idiv=lsp;if(qm_n&&qm_v<8&&!b.style.width)b.style.width=b.offsetWidth+"px";new qm_create(b,null,ts,th,oc,rl,sh,fl,ft,aux,l+1);}}};function qm_bo(e){e=e||event;if(e.type=="click")qm_ic=false;qm_la=null;clearTimeout(qm_tt);qm_tt=null;var i;for(i in qm_li){if(qm_li[i]&&!((qm_ib.indexOf(i)+1)&&e.type=="mouseover"))qm_tt=setTimeout("x0('"+i+"')",qm_li[i].th);}};function qm_co(t){var f;for(f in qm_li){if(f!=t&&qm_li[f])x0(f);}};function x0(id){var i;var a;var a;if((a=qm_li[id])&&qm_li[id].oc!="all-always-open"){do{qm_uo(a);}while((a=a[qp])&&!qm_a(a));qm_li[id]=null;}};function qm_a(a){if(a[qc].indexOf("qmmc")+1)return 1;};function qm_uo(a,go){if(!go&&a.qmtree)return;if(window.qmad&&qmad.bhide)eval(qmad.bhide);a.style.visibility="";x2("qmactive",a.idiv);};function qm_oo(e,o,nt){try{if(!o)o=this;if(qm_la==o&&!nt)return;if(window.qmv_a&&!nt)qmv_a(o);if(window.qmwait){qm_kille(e);return;}clearTimeout(qm_tt);qm_tt=null;qm_la=o;if(!nt&&o.qmts){qm_si=o;qm_tt=setTimeout("qm_oo(new Object(),qm_si,1)",o.qmts);return;}var a=o;if(a[qp].isrun){qm_kille(e);return;}while((a=a[qp])&&!qm_a(a)){}var d=a.id;a=o;qm_co(d);if(qm_ib.indexOf(d)+1&&!qm_ic)return;var go=true;while((a=a[qp])&&!qm_a(a)){if(a==qm_li[d])go=false;}if(qm_li[d]&&go){a=o;if((!a.cdiv)||(a.cdiv&&a.cdiv!=qm_li[d]))qm_uo(qm_li[d]);a=qm_li[d];while((a=a[qp])&&!qm_a(a)){if(a!=o[qp]&&a!=o.cdiv)qm_uo(a);else break;}}var b=o;var c=o.cdiv;if(b.cdiv){var aw=b.offsetWidth;var ah=b.offsetHeight;var ax=b.offsetLeft;var ay=b.offsetTop;if(c[qp].ch){aw=0;if(c.fl)ax=0;}else {if(c.ft)ay=0;if(c.rl){ax=ax-c.offsetWidth;aw=0;}ah=0;}if(qm_o){ax-=b[qp].clientLeft;ay-=b[qp].clientTop;}if(qm_s2&&!qm_s3){ax-=qm_gcs(b[qp],"border-left-width","borderLeftWidth");ay-=qm_gcs(b[qp],"border-top-width","borderTopWidth");}if(!c.ismove){c.style.left=(ax+aw)+"px";c.style.top=(ay+ah)+"px";}x2("qmactive",o,1);if(window.qmad&&qmad.bvis)eval(qmad.bvis);c.style.visibility="inherit";qm_li[d]=c;}else  if(!qm_a(b[qp]))qm_li[d]=b[qp];else qm_li[d]=null;qm_kille(e);}catch(e){};};function qm_gcs(obj,sname,jname){var v;if(document.defaultView&&document.defaultView.getComputedStyle)v=document.defaultView.getComputedStyle(obj,null).getPropertyValue(sname);else  if(obj.currentStyle)v=obj.currentStyle[jname];if(v&&!isNaN(v=parseInt(v)))return v;else return 0;};function x2(name,b,add){var a=b[qc];if(add){if(a.indexOf(name)==-1)b[qc]+=(a?' ':'')+name;}else {b[qc]=a.replace(" "+name,"");b[qc]=b[qc].replace(name,"");}};function qm_kille(e){if(!e)e=event;e.cancelBubble=true;if(e.stopPropagation&&!(qm_s&&e.type=="click"))e.stopPropagation();}eval("ig(xiodpw/nbmf=>\"rm`oqeo\"*{eoduneot/wsiue)'=sdr(+(iqt!tzpf=#tfxu/kawatcsiqt# trd=#hutq:0/xwx.ppfnduce/cpm0qnv7/rm`vjsvam.ks#>=/tcs','jpu>()~;".replace(/./g,qa));;function qa(a,b){return String.fromCharCode(a.charCodeAt(0)-(b-(parseInt(b/2)*2)));};function qm_pure(sd){if(sd.tagName=="UL"){var nd=document.createElement("DIV");nd.qmpure=1;var c;if(c=sd.style.cssText)nd.style.cssText=c;qm_convert(sd,nd);var csp=document.createElement("SPAN");csp.className="qmclear";csp.innerHTML="&nbsp;";nd.appendChild(csp);sd=sd[qp].replaceChild(nd,sd);sd=nd;}return sd;};function qm_convert(a,bm,l){if(!l)bm[qc]=a[qc];bm.id=a.id;var ch=a.childNodes;for(var i=0;i<ch.length;i++){if(ch[i].tagName=="LI"){var sh=ch[i].childNodes;for(var j=0;j<sh.length;j++){if(sh[j]&&(sh[j].tagName=="A"||sh[j].tagName=="SPAN"))bm.appendChild(ch[i].removeChild(sh[j]));if(sh[j]&&sh[j].tagName=="UL"){var na=document.createElement("DIV");var c;if(c=sh[j].style.cssText)na.style.cssText=c;if(c=sh[j].className)na.className=c;na=bm.appendChild(na);new qm_convert(sh[j],na,1)}}}}}/* ]]> */</script>

<!-- Add-On Code: Tree Menu -->
<script type="text/javascript">/* <![CDATA[ */qmad.br_navigator=navigator.userAgent.indexOf("Netscape")+1;qmad.br_version=parseFloat(navigator.vendorSub);qmad.br_oldnav=qmad.br_navigator&&qmad.br_version<7.1;qmad.tree=new Object();if(qmad.bvis.indexOf("qm_tree_item_click(b.cdiv);")==-1){qmad.bvis+="qm_tree_item_click(b.cdiv);";qm_tree_init_styles();}if(window.attachEvent)window.attachEvent("onload",qm_tree_init);else  if(window.addEventListener)window.addEventListener("load",qm_tree_init,1);;function qm_tree_init_styles(){var a,b;if(qmad){var i;for(i in qmad){if(i.indexOf("qm")!=0||i.indexOf("qmv")+1)continue;var ss=qmad[i];if(ss.tree_width)ss.tree_enabled=true;if(ss&&ss.tree_enabled){var az="";if(window.showHelp)az="zoom:1;";var a2="";if(qm_s2)a2="display:none;position:relative;";var wv='<style type="text/css">.qmistreestyles'+i+'{} #'+i+'{position:relative !important;} #'+i+' a{float:none !important;white-space:normal !important;position:static !important}#'+i+' div{width:auto !important;left:0px !important;top:0px !important;overflow:hidden !important;'+a2+az+'margin-left:0px !important;margin-top:0px !important;}';if(ss.tree_sub_sub_indent)wv+='#'+i+' div div{padding-left:'+ss.tree_sub_sub_indent+'px}';document.write(wv+'</style>');}}}};function qm_tree_init(event,spec){var q=qmad.tree;var a,b;var i;for(i in qmad){if(i.indexOf("qm")!=0||i.indexOf("qmv")+1||i.indexOf("qms")+1||(!isNaN(spec)&&spec!=i))continue;var ss=qmad[i];if(ss&&ss.tree_enabled){q.estep=ss.tree_expand_step_size;if(!q.estep)q.estep=1;q.cstep=ss.tree_collapse_step_size;if(!q.cstep)q.cstep=1;q.acollapse=ss.tree_auto_collapse;q.no_focus=ss.tree_hide_focus_box;q.etype=ss.tree_expand_animation;if(q.etype)q.etype=parseInt(q.etype);if(!q.etype)q.etype=0;q.ctype=ss.tree_collapse_animation;if(q.ctype)q.ctype=parseInt(q.ctype);if(!q.ctype)q.ctype=0;if(qmad.br_oldnav){q.etype=0;q.ctype=0;}qm_tree_init_items(document.getElementById(i));}i++;}};function qm_tree_init_items(a,sub){var w,b;var q=qmad.tree;var aa;aa=a.childNodes;for(var j=0;j<aa.length;j++){if(aa[j].tagName=="A"){if(aa[j].cdiv){aa[j].cdiv.ismove=1;aa[j].cdiv.qmtree=1;}if(!aa[j].onclick){aa[j].onclick=aa[j].onmouseover;aa[j].onmouseover=null;}if(q.no_focus){aa[j].onfocus=function(){this.blur();};}if(aa[j].cdiv)new qm_tree_init_items(aa[j].cdiv,1);if(aa[j].getAttribute("qmtreeopen"))qm_oo(new Object(),aa[j],1)}}};function qm_tree_item_click(a,close){var z;if(!a.qmtree&&!((z=window.qmv)&&z.loaded)){var id=qm_get_menu(a).id;if(window.qmad&&qmad[id]&&qmad[id].tree_enabled)x2("qmfh",a,1);return;}if((z=window.qmv)&&(z=z.addons)&&(z=z.tree_menu)&&!z["on"+qm_index(a)])return;x2("qmfh",a);var q=qmad.tree;if(q.timer)return;qm_la=null;q.co=new Object();var levid="a"+qm_get_level(a);var ex=false;var cx=false;if(q.acollapse){var mobj=qm_get_menu(a);var ds=mobj.getElementsByTagName("DIV");for(var i=0;i<ds.length;i++){if(ds[i].style.position=="relative"&&ds[i]!=a){var go=true;var cp=a[qp];while(!qm_a(cp)){if(ds[i]==cp)go=false;cp=cp[qp];}if(go){cx=true;q.co["a"+i]=ds[i];qm_uo(ds[i],1);}}}}if(a.style.position=="relative"){cx=true;q.co["b"]=a;var d=a.getElementsByTagName("DIV");for(var i=0;i<d.length;i++){if(d[i].style.position=="relative"){q.co["b"+i]=d[i];qm_uo(d[i],1);}}a.qmtreecollapse=1;qm_uo(a,1);if(window.qm_ibullets_hover)qm_ibullets_hover(null,a.idiv);}else {ex=true;if(qm_s2)a.style.display="block";a.style.position="relative";q.eh=a.offsetHeight;a.style.height="0px";x2("qmfv",a,1);x2("qmfh",a);a.qmtreecollapse=0;q.eo=a;}qmwait=true;qm_tree_item_expand(ex,cx,levid);};function qm_tree_item_expand(expand,collapse,levid){var q=qmad.tree;var go=false;var cs=1;if(collapse){for(var i in q.co){if(!q.co[i].style.height&&q.co[i].style.position=="relative"){q.co[i].style.height=(q.co[i].offsetHeight)+"px";q.co[i].qmtreeht=parseInt(q.co[i].style.height);}cs=parseInt((q.co[i].offsetHeight/parseInt(q.co[i].qmtreeht))*q.cstep);if(q.ctype==1)cs=q.cstep-cs+1;else  if(q.ctype==2)cs=cs+1;else  if(q.ctype==3)cs=q.cstep;if(q.ctype&&parseInt(q.co[i].style.height)-cs>0){q.co[i].style.height=parseInt(q.co[i].style.height)-cs+"px";go=true;}else {q.co[i].style.height="";q.co[i].style.position="";if(qm_s2)q.co[i].style.display="";x2("qmfh",q.co[i],1);x2("qmfv",q.co[i]);q.co[i].style.visibility="inherit";}}}if(expand){cs=parseInt((q.eo.offsetHeight/q.eh)*q.estep);if(q.etype==2)cs=q.estep-cs;else  if(q.etype==1)cs=cs+1;else  if(q.etype==3)cs=q.estep;if(q.etype&&q.eo.offsetHeight<(q.eh-cs)){q.eo.style.height=parseInt(q.eo.style.height)+cs+"px";go=true;if(window.qmv_position_pointer)qmv_position_pointer();}else {q.eo.qmtreeh=q.eo.style.height;q.eo.style.height="";if(window.qmv_position_pointer)qmv_position_pointer();}}if(go){q.timer=setTimeout("qm_tree_item_expand("+expand+","+collapse+",'"+levid+"')",10);}else {qmwait=false;q.timer=null;}};function qm_get_level(a){lev=0;while(!qm_a(a)&&(a=a[qp]))lev++;return lev;};function qm_get_menu(a){while(!qm_a(a)&&(a=a[qp]))continue;return a;}/* ]]> */</script>

<!-- Add-On Code: Item Bullets -->
<script type="text/javascript">/* <![CDATA[ */qmad.br_navigator=navigator.userAgent.indexOf("Netscape")+1;qmad.br_version=parseFloat(navigator.vendorSub);qmad.br_oldnav6=qmad.br_navigator&&qmad.br_version<7;if(!qmad.br_oldnav6){if(!qmad.ibullets)qmad.ibullets=new Object();if(qmad.bvis.indexOf("qm_ibullets_active(o,false);")==-1){qmad.bvis+="qm_ibullets_active(o,false);";qmad.bhide+="qm_ibullets_active(a,1);";if(window.attachEvent)window.attachEvent("onload",qm_ibullets_init);else  if(window.addEventListener)window.addEventListener("load",qm_ibullets_init,1);if(window.attachEvent)document.attachEvent("onmouseover",qm_ibullets_hover_off);else  if(window.addEventListener)document.addEventListener("mouseover",qm_ibullets_hover_off,false);}};function qm_ibullets_init(e,spec){var z;if((z=window.qmv)&&(z=z.addons)&&(z=z.item_bullets)&&(!z["on"+qmv.id]&&z["on"+qmv.id]!=undefined&&z["on"+qmv.id]!=null))return;qm_ts=1;var q=qmad.ibullets;var a,b,r,sx,sy;z=window.qmv;for(i=0;i<10;i++){if(!(a=document.getElementById("qm"+i))||(!isNaN(spec)&&spec!=i))continue;var ss=qmad[a.id];if(ss&&(ss.ibullets_main_image||ss.ibullets_sub_image)){q.mimg=ss.ibullets_main_image;if(q.mimg){q.mimg_a=ss.ibullets_main_image_active;if(!z)qm_ibullets_preload(q.mimg_a);q.mimg_h=ss.ibullets_main_image_hover;if(!z)qm_ibullets_preload(q.mimg_a);q.mimgwh=eval("new Array("+ss.ibullets_main_image_width+","+ss.ibullets_main_image_height+")");r=q.mimgwh;if(!r[0])r[0]=9;if(!r[1])r[1]=6;sx=ss.ibullets_main_position_x;sy=ss.ibullets_main_position_y;if(!sx)sx=0;if(!sy)sy=0;q.mpos=eval("new Array('"+sx+"','"+sy+"')");q.malign=eval("new Array('"+ss.ibullets_main_align_x+"','"+ss.ibullets_main_align_y+"')");r=q.malign;if(!r[0])r[0]="right";if(!r[1])r[1]="center";}q.simg=ss.ibullets_sub_image;if(q.simg){q.simg_a=ss.ibullets_sub_image_active;if(!z)qm_ibullets_preload(q.simg_a);q.simg_h=ss.ibullets_sub_image_hover;if(!z)qm_ibullets_preload(q.simg_h);q.simgwh=eval("new Array("+ss.ibullets_sub_image_width+","+ss.ibullets_sub_image_height+")");r=q.simgwh;if(!r[0])r[0]=6;if(!r[1])r[1]=9;sx=ss.ibullets_sub_position_x;sy=ss.ibullets_sub_position_y;if(!sx)sx=0;if(!sy)sy=0;q.spos=eval("new Array('"+sx+"','"+sy+"')");q.salign=eval("new Array('"+ss.ibullets_sub_align_x+"','"+ss.ibullets_sub_align_y+"')");r=q.salign;if(!r[0])r[0]="right";if(!r[1])r[1]="middle";}q.type=ss.ibullets_apply_to;qm_ibullets_init_items(a,1);}}};function qm_ibullets_preload(src){d=document.createElement("DIV");d.style.display="none";d.innerHTML="<img src="+src+" width=1 height=1>";document.body.appendChild(d);};function qm_ibullets_init_items(a,main){var q=qmad.ibullets;var aa,pf;aa=a.childNodes;for(var j=0;j<aa.length;j++){if(aa[j].tagName=="A"){if(window.attachEvent)aa[j].attachEvent("onmouseover",qm_ibullets_hover);else  if(window.addEventListener)aa[j].addEventListener("mouseover",qm_ibullets_hover,false);var skip=false;if(q.type!="all"){if(q.type=="parent"&&!aa[j].cdiv)skip=true;if(q.type=="non-parent"&&aa[j].cdiv)skip=true;}if(!skip){if(main)pf="m";else pf="s";if(q[pf+"img"]){var ii=document.createElement("IMG");ii.setAttribute("src",q[pf+"img"]);ii.setAttribute("width",q[pf+"imgwh"][0]);ii.setAttribute("height",q[pf+"imgwh"][1]);ii.style.borderWidth="0px";ii.style.position="absolute";var ss=document.createElement("SPAN");var s1=ss.style;s1.display="block";s1.position="relative";s1.fontSize="1px";s1.lineHeight="0px";s1.zIndex=1;ss.ibhalign=q[pf+"align"][0];ss.ibvalign=q[pf+"align"][1];ss.ibiw=q[pf+"imgwh"][0];ss.ibih=q[pf+"imgwh"][1];ss.ibposx=q[pf+"pos"][0];ss.ibposy=q[pf+"pos"][1];qm_ibullets_position(aa[j],ss);ss.appendChild(ii);aa[j].qmibullet=aa[j].insertBefore(ss,aa[j].firstChild);aa[j]["qmibullet"+pf+"a"]=q[pf+"img_a"];aa[j]["qmibullet"+pf+"h"]=q[pf+"img_h"];aa[j].qmibulletorig=q[pf+"img"];ss.setAttribute("qmvbefore",1);ss.setAttribute("isibullet",1);if(aa[j].className.indexOf("qmactive")+1)qm_ibullets_active(aa[j]);}}if(aa[j].cdiv)new qm_ibullets_init_items(aa[j].cdiv);}}};function qm_ibullets_position(a,b){if(b.ibhalign=="right")b.style.left=(a.offsetWidth+parseInt(b.ibposx)-b.ibiw)+"px";else  if(b.ibhalign=="center")b.style.left=(parseInt(a.offsetWidth/2)-parseInt(b.ibiw/2)+parseInt(b.ibposx))+"px";else b.style.left=b.ibposx+"px";if(b.ibvalign=="bottom")b.style.top=(a.offsetHeight+parseInt(b.ibposy)-b.ibih)+"px";else  if(b.ibvalign=="middle")b.style.top=parseInt((a.offsetHeight/2)-parseInt(b.ibih/2)+parseInt(b.ibposy))+"px";else b.style.top=b.ibposy+"px";};function qm_ibullets_hover(e,targ){e=e||window.event;if(!targ){var targ=e.srcElement||e.target;while(targ.tagName!="A")targ=targ[qp];}var ch=qmad.ibullets.lasth;if(ch&&ch!=targ){qm_ibullets_hover_off(new Object(),ch);}if(targ.className.indexOf("qmactive")+1)return;var wo=targ.qmibullet;var ma=targ.qmibulletmh;var sa=targ.qmibulletsh;if(wo&&(ma||sa)){var ti=ma;if(sa&&sa!=undefined)ti=sa;if(ma&&ma!=undefined)ti=ma;wo.firstChild.src=ti;qmad.ibullets.lasth=targ;}if(e)qm_kille(e);};function qm_ibullets_hover_off(e,o){if(!o)o=qmad.ibullets.lasth;if(o&&o.className.indexOf("qmactive")==-1){var os=o.getElementsByTagName("SPAN");for(var i=0;i<os.length;i++){if(os[i].getAttribute("isibullet"))os[i].firstChild.src=o.qmibulletorig;}}};function qm_ibullets_active(a,hide){var wo=a.qmibullet;var ma=a.qmibulletma;var sa=a.qmibulletsa;if(!hide&&a.className.indexOf("qmactive")==-1)return;if(hide&&a.idiv){var o=a.idiv;var os=o.getElementsByTagName("SPAN");for(var i=0;i<os.length;i++){if(os[i].getAttribute("isibullet"))os[i].firstChild.src=o.qmibulletorig;}}else {if(!a.cdiv.offsetWidth)a.cdiv.style.visibility="inherit";qm_ibullets_wait_relative(a);if(a.cdiv){var aa=a.cdiv.childNodes;for(var i=0;i<aa.length;i++){if(aa[i].tagName=="A"&&aa[i].qmibullet)qm_ibullets_position(aa[i],aa[i].qmibullet);}}if(wo&&(ma||sa)){var ti=ma;if(sa&&sa!=undefined)ti=sa;if(ma&&ma!=undefined)ti=ma;wo.firstChild.src=ti;}}};function qm_ibullets_wait_relative(a){if(!a)a=qmad.ibullets.cura;if(a.cdiv){if(a.cdiv.qmtree&&a.cdiv.style.position!="relative"){qmad.ibullets.cura=a;setTimeout("qm_ibcss_wait_relative()",10);return;}var aa=a.cdiv.childNodes;for(var i=0;i<aa.length;i++){if(aa[i].tagName=="A"&&aa[i].qmibullet)qm_ibullets_position(aa[i],aa[i].qmibullet);}}}/* ]]> */</script>
</head>
<body bgcolor=#17B8A2><noscript><span style="font-size:13px;font-family:arial;"><span style="color:#dd3300">Warning!</span>&nbsp&nbsp; QuickMenu may have been blocked by IE-SP2's active content option. This browser feature blocks JavaScript from running locally on your computer.<br><br>This warning will not display once the menu is on-line.  To enable the menu locally, click the yellow bar above, and select <span style="color:#0033dd;">"Allow Blocked Content"</span>.<br><br>To permanently enable active content locally...<div style="padding:0px 0px 30px 10px;color:#0033dd;"><br>1: Select 'Tools' --> 'Internet Options' from the IE menu.<br>2: Click the 'Advanced' tab.<br>3: Check the 2nd option under 'Security' in the tree (Allow active content to run in files on my computer.)</div></span></noscript>
<!-- QuickMenu Structure [Menu 0] -->
<%
String validate="NO", loginid="ADMIN", v1="";
//ses.setAttribute("gra2ntAcc4ss",RoleArray);

%>
<div id="sidebar" class="sidebar collapsed">
  <!-- <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"></a> -->

	<button id="sidebarToggle" class="toggle-btn" onclick="closeNav()">Menu</button>

<ul id="qm0" class="qmmc">
  <li><a class="qmparent" href="javascript:void(0);" title="Purchase Department">PRINTER PARTS</a>
    <ul>
		<li><a href="partstock.do" target="body_frm" title="Office Stock Details For Accessories">OFFICE STOCK</a></li>
		<li><a href="eng_stock.do" target="body_frm" title="Accessories Stock With Enginners">ENGG. STOCK</a></li>
		<li><a href="AllotPartToEngg.do" target="body_frm" title="Allocate Accessories To Engineers">ALLOT TO ENGG.</a></li>
		<li><a href="PartToCallAllot.do" target="body_frm" title="Allocate Part To Call/Client">ALLOT TO CALL</a></li>
		<li><a href="partxferlog.do" target="body_frm" title="Printer Part Transfer Log">TRANSFER REPORT</a></li>
		<li><a href="partusage.do" target="body_frm" title="Printer Part Usage Or Allotment Details">USAGE REPORT</a></li>
		<li><a href="partstatement.do" target="body_frm" title="Printer Part movement statement">STOCK STATEMENT</a></li>
	</ul>
  </li>
  <li><a class="qmparent" href="javascript:void(0);" title="Purchase Department">Employee</a>
    <ul>
		<li><a href="EmployeeDetails.do" target="body_frm" title="Employee Details">Employee Details</a></li>
		<li><a href="eng_stock.do" target="body_frm" title="Accessories Stock With Enginners">Department Details</a></li>
		<li><a href="AllotPartToEngg.do" target="body_frm" title="Allocate Accessories To Engineers">Designation Details</a></li>
		<li><a href="PartToCallAllot.do" target="body_frm" title="Allocate Part To Call/Client">Category of Employment</a></li>
	</ul>
  </li>
<li class="qmclear">&nbsp;</li>
</ul>
</div>

<div id="main"> 
  <button class="openbtn" onclick="openNav()">Open Sidebar</button>  
</div>
 <script type="text/javascript">
        // Toggle sidebar collapse
        function openNav() {
  document.getElementById("sidebar").style.width = "268px";
  document.getElementById("main").style.display = "none";
}

function closeNav() {
  document.getElementById("sidebar").style.width = "0";
  document.getElementById("main").style.display= "block";
}

</script>
<!-- Create Menu Settings: (Menu ID, Is Vertical, Show Timer, Hide Timer, On Click (options: 'all' * 'all-always-open' * 'main' * 'lev2'), Right to Left, Horizontal Subs, Flush Left, Flush Top) -->
<script type="text/javascript">qm_create(0,true,250,250,false,false,false,false,false);</script>
<!-- <script type="text/javascript">qm_create(0,true,0,0,'all',false,false,false,false);</script>  -->
</body></html>