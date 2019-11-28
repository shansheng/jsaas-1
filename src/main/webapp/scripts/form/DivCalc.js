DivUtil={};

DivUtil.indexOfValue = function(oldVal,newVal){
	var ary = newVal.split(",");
	var sc = "";
	for(var i=0;i<ary.length;i++){
		sc += "'"+oldVal+"'.indexOf('"+ary[i]+"')!=-1";
		sc += "||";
	}
	sc = sc.substring(0,sc.length-2);
	return eval(sc);
};

DivUtil.equalValue = function(oldVal,op,newVal){
	var ary = newVal.split(",");
	var sc = "";
	for(var i=0;i<ary.length;i++){
		sc += "'"+oldVal+"'"+op+"'"+ary[i]+"'";
		sc += "&&";
	}
	sc = sc.substring(0,sc.length-2);
	return eval(sc);
};

DivUtil.parseLogic = function(e,fieldjson){
	var value = e.value;
	var name = e.sender.name;
	var ary = mini.decode(fieldjson);
	var sc = "";
	var fields = e.sender.fields;
	var fieldsValue = {};
	for (var i = 0; i < fields.length; i++) {
		var name = fields[i];
		if(name.indexOf("_name")!=-1)continue;
		var ctl = mini.getbyName(name);
		if(ctl){
			var value = ctl.getValue();
			fieldsValue[fields[i]] = value;
		}
	}
	for(var i=0;i<ary.length;i++){
		var field = ary[i];
		var op = field.op;
		var value = fieldsValue[field.name];
		var jValue = field.value;
		if(op=="include"){
			sc += DivUtil.indexOfValue(value,jValue);
		}else{
			sc += DivUtil.equalValue(value,op,jValue);
		}
		var logic = field.logic;
		if(!logic){
			logic = "||";
		}
		sc += logic;
	}
	sc = sc.substring(0,sc.length-2);
	
	return eval(sc);
}

/**
 * 条件DIV逻辑
 * 
 */
function DivCalc(formId){
	{
		/**
		 * 表单ID
		 */
		this.div=$("."+formId);   
		
	};
	
	/**
	 * 解析逻辑
	 */
	this.parseDiv=function(){
		/**
		 * 解析条件div跳转逻辑
		 */
		this.parseJump();
		/**
		 * 解析条件div显示逻辑
		 */
		this.parseShow();
	},
	
	this.parseJump=function(){
		var self = this;
		var html = this.div.html();
		if(html){
			html=html.trim();
		}
		var container = $(html);
		var els=$("div.div-condition",container);
		
		els.each(function(){
			var obj=$(this);
			self.parseScript(obj,els,"fieldjson_jump",self.calcJump);
		});
	},
	
	this.parseShow=function(){
		var self = this;
		var html = this.div.html();
		if(html){
			html=html.trim();
		}
		var container = $(html);
		var els=$("div.div-condition",container);
		
		els.each(function(){
			var obj=$(this);
			self.parseScript(obj,els,"fieldjson_show",self.calcShow);
		});
	},
	
	/**
	 * 跳转逻辑处理
	 */
	this.calcJump=function(e){
		var els = e.sender.els;
		for(var i=0;i<els.length;i++){
			var obj = $(els[i]);
			var fieldjson_show = obj.attr("fieldjson_jump");
			if(fieldjson_show!="[]"){
				var bl = DivUtil.parseLogic(e,obj.attr("fieldjson_jump"));
				var el = $("#"+obj[0].id);
				if(bl){
					var top = el.offset().top;
					$("html,body,.mini-fit").animate({scrollTop:top},500);
				}
			}
			
		}
	},
	
	/**
	 * 显示逻辑处理
	 */
	this.calcShow=function(e){
		var els = e.sender.els;
		for(var i=0;i<els.length;i++){
			var obj = $(els[i]);
			var bl = false;
			var fieldjson_show = obj.attr("fieldjson_show");
			if(fieldjson_show=="[]"){
				bl=true;
			}else{
				bl = DivUtil.parseLogic(e,obj.attr("fieldjson_show"));
			}
			var el = $("#"+obj[0].id);
			if(bl){
				el.show();
			}else{
				el.hide();
			}
		}
	},
	
	/**
	 * 绑定事件
	 */
	this.parseScript=function(obj,els,fieldName,calc){
		var jsonName = obj.attr(fieldName);
		var fields = this.buildFields();
		var ary = mini.decode(jsonName);
		for(var i=0;i<ary.length;i++){
			var field = ary[i];
			var control = mini.getbyName(field.name);
			var json = {"obj":obj,"fields":fields,"els":els};
			json[fieldName]=jsonName;
			var val = control.value;
			var data = {value:val,sender:{name:field.name,els:els,fields:fields}};
			if(fieldName=="fieldjson_show"){
				this.calcShow(data);
			}
			if(fieldName=="fieldjson_jump"){
				data.sender.fieldjson_jump=jsonName;
				data.sender.obj=obj;
				this.calcJump(data);
			}
			control.set(json);
			control.on("valuechanged",calc);
		}
	},
	
	/**
	 * 获取字段
	 */
	this.buildFields=function(){
		var html = this.div.html().trim();
    	var container=$(html);
    	var fs=[];
    	var els=$("[name]:not(span,.rx-grid,.div-condition)",container);
		els.each(function(){
			var obj=$(this);
			var name=obj.attr("name");
			if(!name)return true;
			fs.push(name);
		});
		return fs;
    }
	
}