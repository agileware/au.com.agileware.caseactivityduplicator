{if !$addBlock}
    <table class="form-layout-compressed">
        <thead>
            <tr class="case-block-row">
                <td width="50%"><strong>{ts}Case{/ts}</strong></td>
                <td><strong>{ts}Activity Assignee(s){/ts}</strong></td>
            </tr>
        </thead>
        <tbody>
{/if}
{if !$addBlock and $blockId > 1}
    {foreach from = $caseNumBlocks item = caseNum}
        {include file="CRM/Caseactivityduplicator/Form/Block/CaseFields.tpl" caseBlockId = $caseNum}
    {/foreach}
{else}
    {include file="CRM/Caseactivityduplicator/Form/Block/CaseFields.tpl" caseBlockId = $blockId}
{/if}

{if !$addBlock}
        <tr>
           <td colspan="2">
               <a id='addCaseBlock' href="#" title={ts}Add{/ts} onClick="buildAdditionalBlocks('Case');return false;">{ts}Add another Case{/ts}</a>
           </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="case-block-row">{ts}Click button below to immediate generate Activities for the selected Cases.{/ts}</div>
            </td>
        </tr>
      </tbody>
    </table>
{/if}