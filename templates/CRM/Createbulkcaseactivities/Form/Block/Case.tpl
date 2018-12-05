{if !$addBlock}
    <div class="case-block-row">
        <div class="case-block-row col-50"><strong>{ts}Case{/ts}</strong></div>
        <td class="case-block-row col-50"><strong>{ts}Activity Assignee(s){/ts}</strong></td>
    </div>
{/if}<div class="clearfix"></div>
{if !$addBlock and $blockId > 1}
    {foreach from = $caseNumBlocks item = caseNum}
        {include file="CRM/Createbulkcaseactivities/Form/Block/CaseFields.tpl" caseBlockId = $caseNum}
    {/foreach}
{else}
    {include file="CRM/Createbulkcaseactivities/Form/Block/CaseFields.tpl" caseBlockId = $blockId}
{/if}

{if !$addBlock}
    <div>
        <div class="case-block-row">
            <a id='addCaseBlock' href="#" title={ts}Add{/ts} onClick="buildAdditionalBlocks('Case');return false;">{ts}Add another case{/ts}</a>
        </div>
    </div>
{/if}