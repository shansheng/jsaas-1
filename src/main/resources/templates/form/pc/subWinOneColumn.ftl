<#setting number_format="#">
<div class="rx-grid rxc grid-d" plugins="rx-grid" style="" label="${ent.comment}" name="${ent.name}" edittype="openwindow" required="false" templateid="dOneColumn"  fwidth="0" fheight="0" treegrid="false" treecolumn="" mwidth="0" wunit="px" mheight="0" hunit="px" formname="" data-options="{required:false}">
    <table style="width:100%;">
        <thead>
            <tr class="firstRow">
            	<#list ent.sysBoAttrs as field>
            		<#assign json="${field.extJson}"?eval />
                    <th class="header" <#if (field.isSingle==0)> displayfield="${field.name}_name" </#if> datatype="${field.dataType}" width="" header="${field.name}"  vtype_name="${field.comment}" length="${field.length}" decimal="${field.decimalLength}" requires="${field.required}" editcontrol="${field.control}"  format="${json.format}">
	                    	${field.comment}
	                </th>
                </#list>	
            </tr>
        </thead>
        <tbody>
            <tr>
            	<#list ent.sysBoAttrs as field>
                    <td header="${field.name}">
                    	<@fieldCtrl field=field inTable=true />
                	</td>
                </#list>	
            
                
            </tr>
        </tbody>
    </table>
    <div id="editWindow_${ent.name}" class="mini-window popup-window-d" title="�༭�ӱ���Ϣ" style="width:780px;height:500px" showmaxbutton="true" showmodal="true" allowresize="true" allowdrag="true">
        <div class="mini-toolbar">
            <a class="mini-button button-d" iconcls="icon-save" plain="true" onclick="saveFormDetail(&#39;${ent.name}&#39;)">����</a><a class="mini-button button-d" iconcls="icon-close" plain="true" onclick="closeFormDetail(&#39;${ent.name}&#39;)">�ر�</a>
        </div>
        <div id="editForm_${ent.name}" class="form">
            <input class="mini-hidden" type="hidden" name="_uid"/>
            <table class="table-detail column-two">
                <thead>
                    <tr class="firstRow">
                        <td colspan="2" align="center">
                            <h2>
                                [${ent.comment}]��ϸ��Ϣ
                            </h2>
                        </td>
                    </tr>
                </thead>
                <tbody>
                	<#list ent.sysBoAttrs as field>
                    <tr>
                        <td>${field.comment}</td>
                        <td><@fieldCtrl field=field inTable=false /></td>
                    </tr>
                    </#list>		
                    
                </tbody>
            </table>
        </div>
    </div>
</div>