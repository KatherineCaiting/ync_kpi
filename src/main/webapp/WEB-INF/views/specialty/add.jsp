<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="staticCtx" value="${pageContext.request.contextPath}/static"/>
<head>
	<title></title>	
<!-- artDialog -->
<script type="text/javascript" src="${staticCtx}/artdialog/artDialog.js?skin=brief"></script>
<script type="text/javascript" src="${staticCtx}/artdialog/plugins/iframeTools.js"></script>
<!-- jquery -->
<script type="text/javascript" src="${staticCtx}/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${staticCtx}/jquery/jqueryForm.js"></script>

<script type="text/javascript">
	var i = 0;//此变量为list集合的索引
	//增加一个新的专业性
	function addSpecialtyName(){
		if(i==1){
			alert("同一部门最多只能添加两个专业性");
			return;
		}
		i = i + 1;
		var html = "专业性：<input id='specialtyName"+ i +"' type='text' name='specialtyList[" + i + "].name' /><br/>";		
		$("#specialty").append(html);
	}	
	//异步获取部门负责人
	function mtName(){		
		var departmentId = $("#departmentId").val();	
		if (departmentId == null || departmentId == undefined || departmentId == '') { 			
			$("#spanId").html("");
		}else{
			$.ajax({
				type : "get",
				url : "${ctx}/admin/specialty/getMt",
				data : {
					departmentId : departmentId
				},
				success : function(data) {	
					$("#spanId").html(data.mt);	
					$("#mt").attr("value",data.mt);
					$("#departmentName").attr("value",data.name);
				}
			});
		}		
	}
	//异步提交表单
	function add(){	
		for(var j=0;j<=i;j++){
			var specialtyName = $("#specialtyName"+j).val();
			if(specialtyName == null || specialtyName == ''){
				alert("请输入专业性名称！");
				return;
			}
		}
		var departmentId = $("#departmentId").val();
		if(departmentId==null||departmentId == ''){
			alert("请选择部门！");
			return;
		}		
		if(i>1){
			alert("对不起，目前只允许添加两个专业性！");
			return;
		}		
		$('#specialtyForm').ajaxSubmit(			
			function(data){				
				if(data=="OK"){
	    			art.dialog.close();	
	    		    var win = art.dialog.open.origin;  
	    		    win.location.reload();	    			
	    		}else if(data=="one"){
	    			/* alert("对不起，您还差一个专业性未添加！"); */
	    			art.dialog.close();	
	    		    var win = art.dialog.open.origin;  
	    		    win.location.reload();	 
	    		}else if(data=="two"){
	    			alert("对不起！该部门已存在2个专业性,请删除后再进行添加");
	    			art.dialog.close();	
	    		    var win = art.dialog.open.origin;  
	    		    win.location.reload();	  
	    		}
			}
		);
	}
	
</script>
</head>
	
<body>
	<form id="specialtyForm" action="add" method="post">
		添加专业性<br/><br/>
		<div id="specialty">
			专业性：<input id="specialtyName0" type="text" name="specialtyList[0].name" /><br/>
		</div>
		<input type="button" value="增加" onclick="addSpecialtyName()" /><br/>
		&nbsp;&nbsp;&nbsp;&nbsp;部门：
				<select name="departmentId" id="departmentId" onchange="mtName()">	
					<option value="">----</option>			
					<c:forEach var="department" items="${departmentList }">					
						<option value="${department.id }" >${department.name }</option>											
					</c:forEach>
				</select><br/>
				<input type="hidden" id="departmentName" name="departmentName" value="" />
		MT负责人：<span id="spanId"></span><br/><br/>	
		<input type="hidden" id="mt" name="mt" value="" />
		<input type="button" style="margin-left: 100px" onclick="add()" value="添加" />			
	</form>
</body>

