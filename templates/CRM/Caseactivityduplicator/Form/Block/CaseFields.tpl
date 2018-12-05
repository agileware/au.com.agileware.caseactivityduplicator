<div id="Case_Block_{$caseBlockId}" class="case-block-row case-row">
    <div class="case-block-row col-50">
        {$form.cases.$caseBlockId.case_id.html}
    </div>
    <div class="case-block-row col-50">
        {$form.cases.$caseBlockId.assignee.html}
    </div>

    {if $caseBlockId > 1 }
        <a href="#" class="case-delete-icon error"><i class="fa fa-close error"></i></a>
    {/if}
</div><div class="clearfix"></div>