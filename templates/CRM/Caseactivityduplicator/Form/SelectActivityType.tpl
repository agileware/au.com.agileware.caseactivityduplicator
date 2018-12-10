<div class="crm-form-top-help-text-block">
        {ts}Case Activity Duplicator enables you to quickly generate Activities for Cases and set the Assignee(s) using a single Activity as a template.{/ts}<br/>
        {ts}Use the field below to select the Activity Type to be used. The fields for this Activity Type will be shown on the following page.{/ts}
</div>
<table class="form-layout-compressed">
  <tbody>
    <tr class="crm-activity-form-block-activity_type_id">
      <td class="label">{$form.activity_type_id.label}</td>
      <td class="view-value">{$form.activity_type_id.html}</td>
    </tr>

    <tr>
      <td>

      </td>
      <td><br>
        {include file="CRM/common/formButtons.tpl" location="bottom"}
      </td>
    </tr>

  </tbody>
</table>

<div class="crm-submit-buttons">

</div>
