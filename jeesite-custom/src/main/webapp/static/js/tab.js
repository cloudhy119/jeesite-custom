function setTab(name,cursel,n){
	for(i=1;i<=n;i++){
		var menu=document.getElementById(name+i);
		var con=document.getElementById("con_"+name+"_"+i);
		menu.className=i==cursel?"hover":"";
		con.style.display=i==cursel?"block":"none";
	}
}

//根据国家切换页签
function setTab_Country(name,curselect,n){
	for(i=1; i<=n; i++){
		var menu = document.getElementById(name+i);
		var con = document.getElementById("con_"+name+"_"+i);
		menu.className = ((i == curselect)?"current":"");
		con.style.display = ((i == curselect)?"block":"none");
	}
}

//切换国家(向右切换)
function setTab_Next(){
	var b = true;
	$('#countryUl').find('li').each(function() {
		if(b){
			if(this.className == "current"){
	        	b = false;
	        	var liId = this.id;
	        	var num = parseInt(liId.replace("country",""));
	        	var id = num + 1 ;
	        	if(id < 12){
	        		//setTab_Country('country',id,11);
	        		//隐藏当前tab
		        	this.className = "";
		        	document.getElementById("con_country_"+num).style.display = "none";
		        	//显示下一个tab
		        	document.getElementById("country"+id).className = "current";
		        	document.getElementById("country"+id).style.display = "block";
        			document.getElementById("con_country_"+id).style.display = "block";
        			//隐藏最左边一个tab
	        		if(num > 3){
	        			var menu = document.getElementById("country"+(num-3));
			    		menu.style.display = "none";
	        		}
	        	}
	        }
		}
    })
}
//切换国家(向左切换)
function setTab_Back(){
	var b = true;
	$('#countryUl').find('li').each(function() {
		if(b){
			if(this.className == "current"){
	        	b = false;
				var liId = this.id;
	        	var num = parseInt(liId.replace("country",""));
	        	var id = num - 1 ;
	        	if(id > 0){
	        		//隐藏当前tab
		        	this.className = "";
		        	document.getElementById("con_country_"+num).style.display = "none";
		        	//显示上一个tab
		        	document.getElementById("country"+id).className = "current";
		        	document.getElementById("country"+id).style.display = "block";
        			document.getElementById("con_country_"+id).style.display = "block";
	        		//隐藏最右边一个tab
	        		if(num < 8){
	        			var menu = document.getElementById("country"+(num+4));
			    		menu.style.display = "none";
	        		}
	        	}
	        }
		}
    })
}

