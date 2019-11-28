
	  	resizeCanvas();
	    //添加窗口尺寸改变响应监听
	   /* $(window).resize(resizeCanvas());*/
	    //页面加载后先设置一下canvas大小
	
		 
		      //窗口尺寸改变响应（修改canvas大小）
		function resizeCanvas() {
		    $("#canvas").attr("width", $(window).width());
		    $("#canvas").attr("height", $(window).height());
		};
	 

        var canvas = document.getElementById("canvas");
        var ctx = canvas.getContext('2d');
 
        function rand(min, max) {
            return parseInt(Math.random() * (max - min + 1) + min);
        }
 
        function Round() {
            //随机大小
            this.r = rand(5, 10);
            //随机位置
            var x = rand(0,canvas.width - this.r);//仿制超出右边界
            this.x = x<this.r ? this.r:x;
            var y = rand(0,canvas.height - this.r);
            this.y = y<this.r ? this.r:y;
            //随机速度
            var speed = rand(1, 3);
            this.speedX = rand(0, 4) > 2 ? speed : -speed;
            this.speedY = rand(0, 4) > 2 ? speed : -speed;
 
        }
        Round.prototype.draw = function() {
                    ctx.fillStyle = 'rgba(31,255,226,1)';
                    ctx.beginPath();
                    ctx.arc(this.x, this.y, this.r, 0, 2 * Math.PI, true);
                    ctx.closePath();
                    ctx.fill();
                }
            Round.prototype.links = function(){
                for (var i=0;i<ballobj.length;i++) {
//                  var ball = ballobj[i];
                    var l = Math.sqrt((ballobj[i].x - this.x)*(ballobj[i].x - this.x)+(ballobj[i].y - this.y)*(ballobj[i].y - this.y));
                    var a = 1/l *100;
                    if(l<250){
                    ctx.beginPath();
                    ctx.moveTo(this.x,this.y);
                    ctx.lineTo(ballobj[i].x,ballobj[i].y);
                    ctx.strokeStyle = 'rgba(31,255,226,'+a+')';
                    ctx.stroke();
                    ctx.closePath();
                    }
            }
            }
            Round.prototype.move = function() {
                this.x += this.speedX/10;
                if (this.x > canvas.width  || this.x < 0) {
                    this.speedX *= -1;
                }
                this.y += this.speedY/10;
                if (this.y > canvas.height  || this.y < 0) {
                    this.speedY *= -1;
                }
            }
        var ballobj = [];
 
        function init() {
            for (var i = 0; i < 40; i++) { //小球大小
                var obj = new Round();
                obj.draw();
                obj.move();
                ballobj.push(obj);
            }
        }
        init();
        function ballmove(){
            ctx.clearRect(0,0,canvas.width,canvas.height);
            for (var i=0;i<ballobj.length;i++) {
                var ball = ballobj[i];
                ball.draw();
                ball.move();
                ball.links();
            }
            window.requestAnimationFrame(ballmove);
        }
        ballmove();
        
        
        $(window).resize(function(){
        	resizeCanvas();
        });	

		