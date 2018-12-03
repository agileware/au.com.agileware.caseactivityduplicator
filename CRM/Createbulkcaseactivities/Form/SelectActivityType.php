<?php

use CRM_Createbulkcaseactivities_ExtensionUtil as E;

/**
 * Form controller class
 *
 * @see https://wiki.civicrm.org/confluence/display/CRMDOC/QuickForm+Reference
 */
class CRM_Createbulkcaseactivities_Form_SelectActivityType extends CRM_Core_Form {
  public function buildQuickForm() {

    $activityTypeValues = array(
      '' => '- ' . ts('select') . ' -',
    );
    $activityTypes = civicrm_api3('OptionValue', 'get', [
      'sequential'      => 1,
      'option_group_id' => "activity_type",
    ]);
    $activityTypes = $activityTypes['values'];

    foreach ($activityTypes as $activityType) {
      $activityTypeValues[$activityType['value']] = $activityType['label'];
    }

    $this->add('select', 'activity_type_id', ts('Activity Type'), $activityTypeValues, TRUE, array(
      'class' => 'crm-select2 required',
    ));

    $this->addButtons(array(
      array(
        'type' => 'submit',
        'name' => E::ts('Submit'),
        'isDefault' => TRUE,
      ),
    ));

    parent::buildQuickForm();
  }

  public function postProcess() {
    $values = $this->exportValues();
    $activityTypeId = CRM_Utils_Array::value("activity_type_id", $values, "");

    CRM_Utils_System::redirect(CRM_Utils_System::url('civicrm/createbulkcaseactivities/create', array(
      'atype' => $activityTypeId,
    )));
  }

}
