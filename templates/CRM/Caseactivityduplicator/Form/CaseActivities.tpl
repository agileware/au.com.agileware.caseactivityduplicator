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
    <div class="messages help">
        {ts}Use the fields below to set the values to be copied to each Activity that is created.{/ts}
    </div>
    {* this template is used for adding/editing activities for a case. *}
    <div class="crm-block crm-form-block crm-case-activity-form-block">
        <table class="form-layout">
            {* Block for change status, case type and start date. *}
            <tr class="crm-case-activity-form-block-activity-details">
                 <td colspan="2">
                    {* End block for change status, case type and start date. *}
                    <table class="form-layout-compressed">
                        <tbody>

                            <tr class="crm-case-activity-form-block-source_contact_id">
                                <td class="label">{$form.source_contact_id.label}</td>
                                <td class="view-value">{$form.source_contact_id.html}</td>
                            </tr>

                            <tr class="crm-case-activity-form-block-subject">
                                <td class="label">{$form.subject.label}</td><td class="view-value">{$form.subject.html|crmAddClass:huge}</td>
                            </tr>

                            <tr class="crm-case-activity-form-block-medium_id">
                                <td class="label">{$form.medium_id.label}</td>
                                <td class="view-value">{$form.medium_id.html}&nbsp;&nbsp;&nbsp;{$form.location.label} &nbsp;{$form.location.html|crmAddClass:huge}</td>
                            </tr>
                            <tr class="crm-case-activity-form-block-activity_date_time">
                                <td class="label">{$form.activity_date_time.label}</td>
                                <td class="view-value">{include file="CRM/common/jcalendar.tpl" elementName=activity_date_time}</td>
                            </tr>
                            <tr>
                                <td colspan="2"><div id="customData"></div></td>
                            </tr>
                            <tr class="crm-case-activity-form-block-details">
                                <td class="label">{$form.details.label}</td>
                                <td class="view-value">
                                    {$form.details.html}
                                </td>
                            </tr>
                            <tr class="crm-case-activity-form-block-duration">
                                <td class="label">{$form.duration.label}</td>
                                <td class="view-value">
                                    {$form.duration.html}
                                    <span class="description">{ts}minutes{/ts}</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
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

        </table>

        {crmRegion name='case-activity-form'}{/crmRegion}
    </div>

    <div>
        <h1 class="title">Step 3 - Select the Cases and Assignees</h1>
        <div class="messages help">
            {ts}Select a Case and the Assignees for each Activity to be created.{/ts}<br/>
            {ts}You can also select the same Case multiple times, if you want to create Activities with individual Assignees.{/ts}<br/>
            {ts}An email notification may be sent for each new Activity, based on the CiviCRM configuration (<em>Administer - Settings - Display Preferences, Do not notify assignees for</em>){/ts}.
        </div>
        <div class="crm-block crm-form-block crm-case-activity-form-block crm-case-selection-block">
            <div class="form-layout">
                <div style="width: 100%">
                    {include file="CRM/Caseactivityduplicator/Form/Block/Case.tpl"}
                </div>
            </div>
        </div>
        <div class="crm-submit-buttons">
            {include file="CRM/common/formButtons.tpl" location="bottom"}
        </div>
    </div>

    <div>
        {if $action eq 1 or $action eq 2}
            {*include custom data js file*}
            {include file="CRM/common/customData.tpl"}
            {literal}
                <script type="text/javascript">
                    CRM.$(function($) {

                        CRM.$("body").on('click', '.case-delete-icon', function(e){
                            e.preventDefault();
                            CRM.$(this).parents('.case-block-row').remove();
                            CRM.$('input[name="case_blocks"]').val(CRM.$('.case-row').size());
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
                                html = html.replace(/\n|\r/g, "");
                                var r = /<div>.*<\/div>/gi;
                                html = html.replace(r,"");
                                cj(fname).after(html);
                                cj(fname).nextAll().trigger('crmLoad');
                            }
                        });
                    }


                </script>
            {/literal}
        {/if}

        <script type="text/javascript">
            cj('#follow-up').crmAccordionToggle();
        </script>

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