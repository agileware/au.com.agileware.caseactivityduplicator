{*
 +--------------------------------------------------------------------+
 | CiviCRM version 5                                                  |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2018                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}

{if $addBlock}
  {include file="CRM/Caseactivityduplicator/Form/Block/Case.tpl"}
{else}
    <div class="crm-form-top-help-text-block">
        Use the fields below to set the values to be copied to each Activity that is created.
    </div>
    {* this template is used for adding/editing activities for a case. *}
    <div class="crm-block crm-form-block crm-case-activity-form-block">

      {if $action neq 8 and $action  neq 32768 }

        {* added onload javascript for source contact*}
        {include file="CRM/Activity/Form/ActivityJs.tpl" tokenContext="case_activity"}

      {/if}

      {if $action eq 8 or $action eq 32768 }
      <div class="messages status no-popup">
        <i class="crm-i fa-info-circle"></i> &nbsp;
        {if $action eq 8}
          {ts 1=$activityTypeName}Click Delete to move this &quot;%1&quot; activity to the Trash.{/ts}
        {else}
          {ts 1=$activityTypeName}Click Restore to retrieve this &quot;%1&quot; activity from the Trash.{/ts}
        {/if}
      </div><br />
      {else}
      <table class="form-layout">
        {if $activityTypeDescription }
          <tr>
            <div class="help">{$activityTypeDescription}</div>
          </tr>
        {/if}
        {* Block for change status, case type and start date. *}
        {if $activityTypeFile EQ 'ChangeCaseStatus'
        || $activityTypeFile EQ 'ChangeCaseType'
        || $activityTypeFile EQ 'LinkCases'
        || $activityTypeFile EQ 'ChangeCaseStartDate'}
        {include file="CRM/Case/Form/Activity/$activityTypeFile.tpl"}
        <tr class="crm-case-activity-form-block-details">
          <td class="label">{ts}Details{/ts}</td>
          <td class="view-value">
            {$form.details.html}
          </td>
        </tr>
        {* Added Activity Details accordion tab *}
        <tr class="crm-case-activity-form-block-activity-details">
          <td colspan="2">
            <div id="activity-details" class="crm-accordion-wrapper collapsed">
              <div class="crm-accordion-header">
                {ts}Activity Details{/ts}
              </div><!-- /.crm-accordion-header -->
              <div class="crm-accordion-body">
                {else}
        <tr class="crm-case-activity-form-block-activity-details">
          <td colspan="2">
            {/if}
            {* End block for change status, case type and start date. *}
            <table class="form-layout-compressed">
              <tbody>

              <tr class="crm-case-activity-form-block-source_contact_id">
                <td class="label">{$form.source_contact_id.label}</td>
                <td class="view-value">{$form.source_contact_id.html}</td>
              </tr>

              {* Include special processing fields if any are defined for this activity type (e.g. Change Case Status / Change Case Type). *}

              {if $activityTypeFile neq 'ChangeCaseStartDate'}
                <tr class="crm-case-activity-form-block-subject">
                  <td class="label">{$form.subject.label}</td><td class="view-value">{$form.subject.html|crmAddClass:huge}</td>
                </tr>
              {/if}
              <tr class="crm-case-activity-form-block-medium_id">
                <td class="label">{$form.medium_id.label}</td>
                <td class="view-value">{$form.medium_id.html}&nbsp;&nbsp;&nbsp;{$form.location.label} &nbsp;{$form.location.html|crmAddClass:huge}</td>
              </tr>
              <tr class="crm-case-activity-form-block-activity_date_time">
                <td class="label">{$form.activity_date_time.label}</td>
                {if $action eq 2 && $activityTypeFile eq 'OpenCase'}
                  <td class="view-value">{$current_activity_date_time|crmDate}
                    <div class="description">Use a <a href="{$changeStartURL}">Change Start Date</a> activity to change the date</div>
                    {* avoid errors about missing field *}
                    <div style="display: none;">{include file="CRM/common/jcalendar.tpl" elementName=activity_date_time}</div>
                  </td>
                {else}
                  <td class="view-value">{include file="CRM/common/jcalendar.tpl" elementName=activity_date_time}</td>
                {/if}
              </tr>
              {if $action eq 2 && $activityTypeFile eq 'OpenCase'}
                <tr class="crm-case-activity-form-block-details">
                  <td class="label">{ts}Notes{/ts}</td>
                  <td class="view-value">
                    {$form.details.html}
                  </td>
                </tr>
              {/if}
              <tr>
                <td colspan="2"><div id="customData"></div></td>
              </tr>
              {if NOT $activityTypeFile}
                <tr class="crm-case-activity-form-block-details">
                  <td class="label">{$form.details.label}</td>
                  <td class="view-value">
                    {$form.details.html}
                  </td>
                </tr>
              {/if}
              <tr class="crm-case-activity-form-block-duration">
                <td class="label">{$form.duration.label}</td>
                <td class="view-value">
                  {$form.duration.html}
                  <span class="description">{ts}minutes{/ts}</span>
                </td>
              </tr>
            </table>
            {if $activityTypeFile EQ 'ChangeCaseStatus'
            || $activityTypeFile EQ 'ChangeCaseType'
            || $activityTypeFile EQ 'ChangeCaseStartDate'}
    </div><!-- /.crm-accordion-body -->
    </div><!-- /.crm-accordion-wrapper -->
    {* End of Activity Details accordion tab *}
  {/if}
    </td>
    </tr>
    <tr class="crm-case-activity-form-block-attachment">
      <td colspan="2">{include file="CRM/Form/attachment.tpl"}</td>
    </tr>
    <tr class="crm-case-activity-form-block-schedule_followup">
      <td colspan="2">
        {include file="CRM/Activity/Form/FollowUp.tpl" type="case-"}
      </td>
    </tr>
    {* Suppress activity status and priority for changes to status, case type and start date. PostProc will force status to completed. *}
    {if $activityTypeFile NEQ 'ChangeCaseStatus'
    && $activityTypeFile NEQ 'ChangeCaseType'
    && $activityTypeFile NEQ 'ChangeCaseStartDate'}
      <tr>
        <td colspan="2">
          <table class="form-layout-compressed">
            <tr class="crm-case-activity-form-block-status_id">
              <td class="label">{$form.status_id.label}</td><td class="view-value">{$form.status_id.html}</td>
            </tr>
            <tr class="crm-case-activity-form-block-priority_id">
              <td class="label">{$form.priority_id.label}</td><td class="view-value">{$form.priority_id.html}</td>
            </tr>
          </table>
        </td>
      </tr>
    {/if}
    {if $form.tag.html}
      <tr class="crm-case-activity-form-block-tag">
        <td class="label">{$form.tag.label}</td>
        <td class="view-value">
          <div class="crm-select-container">{$form.tag.html}</div>
        </td>
      </tr>
    {/if}
    <tr class="crm-case-activity-form-block-tag_set"><td colspan="2">{include file="CRM/common/Tagset.tpl" tagsetType='activity'}</td></tr>
    </table>

  {/if}

    {crmRegion name='case-activity-form'}{/crmRegion}
</div>

    <div>

        <h1 class="title" id="page-title">Step 3 - Select the Cases and Assignees</h1>

        <div class="crm-form-top-help-text-block">
            Select a Case and the Assignees to be assigned to each Activity that will be created.<br/>
            You can also select the same Case multiple times, if you want to create Activities with individual Assignees.<br/>
            An email notification may be sent for each new Activity, based on the CiviCRM configuration (Administer - Settings - Display Preferences, Do not notify assignees for).
        </div>

        <div class="crm-block crm-form-block crm-case-activity-form-block crm-case-selection-block">
            <div class="form-layout">
                <div style="width: 100%">
                    {include file="CRM/Caseactivityduplicator/Form/Block/Case.tpl"}
                </div>
            </div>
            <div class="clearfix"></div>
        </div>


    <br>

    <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="bottom"}</div>

    {if $action eq 1 or $action eq 2}
      {*include custom data js file*}
      {include file="CRM/common/customData.tpl"}
    {literal}
      <script type="text/javascript">
          CRM.$(function($) {

              CRM.$("body").on('click', '.case-delete-icon', function(e){
                 e.preventDefault();
                 CRM.$(this).parent().remove();
                  CRM.$('input[name="case_blocks"]').val(CRM.$('.case-row').size());
              });

              var doNotNotifyAssigneeFor = {/literal}{$doNotNotifyAssigneeFor|@json_encode}{literal};
              $('#activity_type_id').change(function() {
                  if ($.inArray($(this).val(), doNotNotifyAssigneeFor) != -1) {
                      $('#notify_assignee_msg').hide();
                  }
                  else {
                      $('#notify_assignee_msg').show();
                  }
              });

            {/literal}
            {if $customDataSubType}
              CRM.buildCustomData( '{$customDataType}', {$customDataSubType} );
            {else}
              CRM.buildCustomData( '{$customDataType}' );
            {/if}
            {literal}
          });


          function buildAdditionalBlocks( blockName ) {
              var element = blockName + '_Block_';

              //get blockcount of last element of relevant blockName
              var previousInstance = cj( '[id^="'+ element +'"]:last' ).attr('id').slice( element.length );
              var currentInstance  = parseInt( previousInstance ) + 1;

              CRM.$('input[name="case_blocks"]').val(currentInstance);

              var dataUrl = {/literal}"{crmURL h=0 q='snippet=4'}"{literal} + '&block=' + blockName + '&count=' + currentInstance;;

              {/literal}
                {if $qfKey}
                  dataUrl += "&qfKey={$qfKey}";
                {/if}
              {literal}

              if ( !dataUrl ) {
                  return;
              }

              var fname = '#' + blockName + '_Block_'+ previousInstance;

              cj.ajax({
                  url     : dataUrl,
                  async   : false,
                  success : function(html){
                      cj(fname).after(html);
                      cj(fname).nextAll().trigger('crmLoad');
                  }
              });

              if ( blockName == 'Address' ) {
                  checkLocation('address_' + currentInstance + '_location_type_id', true );
                  /* FIX: for IE, To get the focus after adding new address block on first element */
                  cj('#address_' + currentInstance + '_location_type_id').focus();
              }
          }


      </script>
    {/literal}
    {/if}

    {if $action neq 8 and $action neq 32768 and empty($activityTypeFile)}
      <script type="text/javascript">
        {if $searchRows}
        cj('#sendcopy').crmAccordionToggle();
        {/if}

        cj('#follow-up').crmAccordionToggle();
      </script>
    {/if}

    {if $action eq 2 or $action eq 1}
    {literal}
      <script type="text/javascript">
          CRM.$(function($) {
              $('.crm-with-contact').click(function() {
                  $('#with-contacts-widget').toggle();
                  $('#with-clients').toggle();
                  return false;
              });
          });
      </script>
    {/literal}
    {/if}
    </div>

{/if}