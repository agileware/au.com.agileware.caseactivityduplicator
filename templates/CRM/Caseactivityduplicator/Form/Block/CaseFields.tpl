<tr id="Case_Block_{$caseBlockId}" class="case-block-row case-row">
    <td width="50%">{$form.cases.$caseBlockId.case_id.html}</td>
    <td>
        {$form.cases.$caseBlockId.assignee.html}
        {if $caseBlockId > 1 }
            <a href="#" class="case-delete-icon error"><i class="fa fa-close error"></i></a>
        {/if}
    </td>
</tr>