<#assign colSize=colsJson?size>
<#assign searchSize=querySearchJson?size>

<#assign searchName="">

<#list querySearchJson as queryItem>
	<#if (queryItem_index==0)>
		<#assign searchName=getSearchParams(queryItem)>
	</#if>
</#list>

<#function getSearchParams item>
<#assign rtn>Q_${item.fieldName}_${item.queryDataType}_${item.fieldOp}</#assign>
 <#return rtn>
</#function>
<yd-layout>
	<yd-navbar bgcolor="#5698c3" color="#FFF" slot="navbar" title="${sysBoList.name}">
      <a href="javascript:;" v-on:click="goBack" slot="left">
        <yd-navbar-back-icon></yd-navbar-back-icon>
      </a>
    </yd-navbar>
    <#if (searchSize>0) >
    <rx-search slot="top" v-model="search.${searchName}" v-on:input="handSearch" <#if (searchSize >1) > :senior="true" </#if><#if (searchSize>1) > v-on:showsenior="showSenior()" </#if> ></rx-search>
    </#if>
    <!--参数-->
    <#if (searchSize>1) >
    <rx-searchpanel v-on:search="handSearch" ref="searchPanel" >
    	<#list querySearchJson as item>
    	<div class="search-params">
    		<div class="title">
    			${item.fieldLabel}
    		</div>
    		<div class="content">
    			<#if (item.fc=="mini-textbox") >
    				<input  v-model="search.${getSearchParams(item)}"  placeholder="请输入${item.fieldLabel}"/>
    			<#elseif (item.fc=="mini-datepicker") >
    				<rx-date v-model="search.${getSearchParams(item)}"></rx-date>
    			<#elseif (item.fc=="mini-combobox") >
    				<#if item.from??>
	    				<#switch item.from>
	    					<#case "self">   
	    						<rx-combo v-model="search.${getSearchParams(item)}" 
	    							conf='{from:"self",data:${SysBoListUtil.removeByKeys(item.selOptions,'_id,_uid,_state')}}' ></rx-combo>
	    					<#break>
	    					<#case "url">   
	    						<rx-combo v-model="search.${getSearchParams(item)}" 
	    							conf='{from:"url",textfield:"${item.url_textfield}",valuefield,"${item.url_valuefield}",url:"${item.url}"}' ></rx-combo>
	    					<#break> 
	    					<#case "dic">   
	    						<rx-combo v-model="search.${getSearchParams(item)}" 
	    							conf='{from:"dic",dic:"${item.dickey}"}' ></rx-combo>
	    					<#break> 
	    					<#case "sql">   
	    						<rx-combo v-model="search.${getSearchParams(item)}" 
	    							conf='{from:"sql",sql:"${item.sql}", data_options:{sql:{sql:"${item.sql}"}},textfield:"${item.sql_textfield}",valuefield:"${item.sql_valuefield}"}' ></rx-combo>
	    					<#break> 
	    					  
	    				</#switch>
    				</#if>
    			<#elseif (item.fc=="mini-dialog") >
    				<rx-btnedit v-model="search.${getSearchParams(item)}" :conf='{dialogalias:"${item.dialogalias}",valueField:"${item.valueField}",textField:"${item.textField}"}'></rx-btnedit>
    			</#if>
    		</div>
    	</div>
		</#list>
    </rx-searchpanel>
    </#if>
    <!-- 列表字段 -->
    <yd-pullrefresh :on-infinite="loadList" ref="pullrefreshList_">
    		<div v-for="item in list" v-if="list && list.length>0" class="custom-list">
    			<div class="head">
						<#if (sysBoList.isDialog=='YES') >
							<#if (sysBoList.multiSelect=="true")>
								<rx-check v-model="selectIds" :val="item.${sysBoList.idField}"></rx-check>
							<#else>
								<rx-radio name="selectId" :val="item.${sysBoList.idField}" v-model="selectIds"></rx-radio>
							</#if>
						<#else>
							<rx-check v-model="selectIds" :val="item.${sysBoList.idField}"></rx-check>
						</#if>
						<div class="allField">
							<div class="hostField">
			    				<#list mobileCols as mobileCol>
									<#if ((mobileCol.mobileShowMode!"")=='host')>
										<span>
				    						<#if (mobileCol.field=='INST_ID_')>
					    						<router-link :to="{name:'getInstInfo', params: { instId: item.${mobileCol.field},type:'inst'  }}" ></router-link>
						    				<#elseif (mobileCol.field=='INST_STATUS_')>
				    							{{getStatusDisplay(item.INST_STATUS_)}}
					    					<#else>
					    						{{item.${mobileCol.field}}}
					    					</#if>
										</span>
									</#if>
			    				</#list>
							</div>
							<div class="unhostField">
			    				<#list mobileCols as mobileCol>
									<#if ((mobileCol.mobileShowMode!"")=='unhost')>
			    						<div class="field">
				    						<#if (mobileCol.field=='INST_ID_')>
					    						${mobileCol.header}:<router-link :to="{name:'getInstInfo', params: { instId: item.${mobileCol.field},type:'inst'  }}" ></router-link>
						    				<#elseif (mobileCol.field=='INST_STATUS_')>
				    							${mobileCol.header}:{{getStatusDisplay(item.INST_STATUS_)}}
					    					<#else>
					    						${mobileCol.header}:{{item.${mobileCol.field}}}
					    					</#if>
				    					</div>
									</#if>
			    				</#list>
							</div>
						</div>
	    		</div>
    		</div>
	  		<a @click="loadList(false,true)" class="loadMore" v-show="list.length < total">点击加载更多...</a>
			<span class="noMore" v-show="list.length >= total">没有更多了</span>
    </yd-pullrefresh>
	
	<#if (sysBoList.isDialog=='YES') >
		<ul class="navBox">
			<li @click="clickOk()">
				<div>
					<svg class="icon" aria-hidden="true">
					  <use xlink:href="#yd-icon-queding"></use>
					</svg>
				</div>
				<div>确定</div>
			</li>
			<li @click="clickClose()">
				<div>
					<svg class="icon" aria-hidden="true">
					  <use xlink:href="#yd-icon-quxiao"></use>
					</svg>
				</div>
				<div>取消</div>
			</li>
		</ul>
	<#else>
		<#if (sysBoList.formAlias ?? && sysBoList.formAlias?length>0) >
			<ul class="navBox" v-if="topBtnsJson.Add=='YES'||topBtnsJson.Detail=='YES'||topBtnsJson.Edit=='YES'||topBtnsJson.Remove=='YES'">
				<li v-if="topBtnsJson.Add=='YES'" @click="formAdd()">
					<div>
						<svg class="icon" aria-hidden="true">
						  <use xlink:href="#yd-icon-tianjia"></use>
						</svg>
					</div>
					<div>添加</div>
				</li>
				<li v-if="topBtnsJson.Detail=='YES'" @click="formDetail()">
					<div>
						<svg class="icon" aria-hidden="true">
						  <use xlink:href="#yd-icon-wendang1"></use>
						</svg>
					</div>
					<div>明细</div>
				</li>
				<li v-if="topBtnsJson.Edit=='YES'" @click="formEdit()">
					<div>
						<svg class="icon" aria-hidden="true">
						  <use xlink:href="#yd-icon-bianji"></use>
						</svg>
					</div>
					<div>编辑</div>
				</li>
				<li v-if="topBtnsJson.Remove=='YES'" @click="formDel()">
					<div>
						<svg class="icon" aria-hidden="true">
						  <use xlink:href="#yd-icon-shanchu"></use>
						</svg>
					</div>
					<div>删除</div>
				</li>
			</ul>
    	</#if>
	</#if>
	
</yd-layout>
<script>
//参数
var params_json={
	search:{
		<#list querySearchJson as queryItem>
			<#if !queryItem_has_next>"${getSearchParams(queryItem)}":""<#else>"${getSearchParams(queryItem)}":"",</#if>
		</#list>
	},
	result:[<#list fieldsJson as item><#if !item_has_next>"${item.field}"<#else>"${item.field}",</#if></#list>]
};

</script>