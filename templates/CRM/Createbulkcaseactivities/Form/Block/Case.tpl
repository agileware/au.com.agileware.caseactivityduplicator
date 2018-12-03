{if !$addBlock}
    <div style="width: 100%; float:left;">
        <div style="width: 50%; float:left;"><strong>{ts}Case{/ts}</strong></div>
        <td style="width: 50%; float:left;"><strong>{ts}Activity Assignee(s){/ts}</strong></td>
    </div>
{/if}<div class="clearfix"></div>
<div id="Case_Block_{$blockId}" style="width: 100%; margin-top: 15px;">
    <div style="width: 50%; float:left;">
        {$form.case.$blockId.case_id.html}
    </div>
    <div style="width: 50%; float:left;">
        {$form.case.$blockId.assignee.html}
    </div>
</div><div class="clearfix"></div>
{if !$addBlock}
    <div>
        <div style="width: 100%; float:left;">
            <a id='addCaseBlock' href="#" title={ts}Add{/ts} onClick="buildAdditionalBlocks('Case');return false;">{ts}Add another case{/ts}</a>
        </div>
    </div>
{/if}