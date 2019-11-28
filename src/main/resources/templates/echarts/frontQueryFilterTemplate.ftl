<div id="queryFilterContainer" class="colId_${colId} modularBox" colId="${colId}" style="width:100%;height:100%;padding:0;">
	<form id="queryFilterContainerFrm" method="post">
		<#list queryJson as single>
			<#assign json = single?eval />
			<div style="display:inline-block;width:${json.pluginWidth}%;height:auto;line-height:40px;margin:0;padding:0;float:left;">
				<table style="width:100%;">
					<tr>
						<td style="width:100px;text-align:right;padding-right:10px;"><label>${json.name}</label></td>
						<td>
							<#if json.pluginType == "mini-combobox">
								<#if json.dataSource.from == "custom">
									<#assign cData = "["/>
									<#list json.dataSource.customData as customData>
										<#assign cData += "{"/>
										<#list customData ? keys as key>
											<#assign cData += ("'" + key + "':'" + customData["${key}"] + "', ") />
										</#list>
										<#assign cData += "},"/>
									</#list>
									<#assign cData += "]"/>
									<input name="${json.key}" class="${json.pluginType}" mini-custom-setting" style="width:90%;" 
											data="${cData}" textField="key" valueField="name"
										/>
								</#if>
								<#if json.dataSource.from == "dic">
									<input name="${json.key}" class="${json.pluginType}" mini-custom-setting" style="width:90%;" 
											url="${ctxPath}/sys/core/sysDic/listByKey.do?key=${json.dataSource.dicKey}" 
											textField="name" valueField="value"
										/>
								</#if>
								<#if json.dataSource.from == "customSql">
									<input name="${json.key}" class="${json.pluginType}" mini-custom-setting" style="width:90%;" 
											url="${ctxPath}/sys/db/sysSqlCustomQuery/queryForJson_${json.dataSource.sql}.do" 
											textField="${json.dataSource.textField}" valueField="${json.dataSource.valueField}"
										/>
								</#if>
							</#if>
							<#if json.pluginType == "mini-textbox">
								<input name="${json.key}" class="${json.pluginType} mini-custom-setting" style="width:90%"/>
							</#if>
							<#if json.pluginType == "mini-datepicker">
								<input name="${json.key}" class="${json.pluginType}"/>
								至
								<input name="${json.key}" class="${json.pluginType}"/>
							</#if>
						</td>
					</tr>
				</table>
			</div>
		</#list>
	</form>
	<div style="width:100%;height:auto;line-height:40px;margin:0;padding:0;">
		<table>
			<tr>
				<td style="width:100px;padding-right:10px;"></td>
				<td><a class="mini-button" style="padding-left:10px;padding-right:10px;" onclick="submitDashboard()">查询</a></td>
			</tr>
		</table>
	</div>
</div>