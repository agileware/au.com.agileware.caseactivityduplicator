{if !$addBlock}
    <div class="case-block-row">
        <div class="case-block-row col-50"><strong>{ts}Case{/ts}</strong></div>
        <div class="case-block-row col-50"><strong>{ts}Activity Assignee(s){/ts}</strong></div>
    </div>
{/if}
{if !$addBlock and $blockId > 1}
    {foreach from = $caseNumBlocks item = caseNum}
        {include file="CRM/Caseactivityduplicator/Form/Block/CaseFields.tpl" caseBlockId = $caseNum}
    {/foreach}
{else}
    {include file="CRM/Caseactivityduplicator/Form/Block/CaseFields.tpl" caseBlockId = $blockId}
{/if}

{if !$addBlock}
    <div>
        <div class="case-block-row">
            <a id='addCaseBlock' href="#" title={ts}Add{/ts} onClick="buildAdditionalBlocks('Case');return false;">{ts}Add another Case{/ts}</a>
        </div>
    </div>
{/if}
<div class="crm-form-top-help-text-block">
        {ts}Use the button below to generate the multiple Activities for the selected Cases.{/ts}
</div>