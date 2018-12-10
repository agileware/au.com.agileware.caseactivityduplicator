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
    <div class="case-block-row case-block-bottom-instruction">
        <div class="case-block-row">{ts}Click button below to immediate generate Activities for the selected Cases.{/ts}</div>
    </div>
{/if}