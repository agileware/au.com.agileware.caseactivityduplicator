<?php

use CRM_Createbulkcaseactivities_ExtensionUtil as E;

/**
 * Form controller class
 *
 * @see https://wiki.civicrm.org/confluence/display/CRMDOC/QuickForm+Reference
 */
class CRM_Createbulkcaseactivities_Form_CaseActivities extends CRM_Activity_Form_Activity {

  public $isRequestForBlock = FALSE;
  public function preProcess() {

    parent::preProcess();
  }

  /**
   * Set default values for the form.
   */
  public function setDefaultValues() {
    return parent::setDefaultValues();
  }

  public function buildQuickForm() {
    $blockId = 0;

    $block = CRM_Utils_Request::retrieve('block', 'String', $form, FALSE, "");
    if ($block) {
      $this->isRequestForBlock = TRUE;
      $blockId = CRM_Utils_Request::retrieve('count', 'Positive', $form, FALSE, 1);
      $this->assign('blockId', $blockId);
      $this->addBlockReferences($blockId);
      $this->assign('addBlock', TRUE);
    }
    else {
      $this->_action = CRM_Core_Action::ADD;
      $this->_fields['source_contact_id']['label'] = ts('Reported By');
      $encounterMediums = CRM_Case_PseudoConstant::encounterMedium();
      $this->add('select', 'medium_id', ts('Medium'), $encounterMediums, TRUE);
      $this->assign('addBlock', FALSE);
      $this->assign('blockId', $blockId);
      $this->addBlockReferences($blockId);

      CRM_Utils_System::setTitle("Activity Details");
      parent::buildQuickForm();
    }
  }

  public function addBlockReferences($blockId) {
    $this->addEntityRef("case[$blockId][case_id]", 'Case', array(
      'entity' => 'Case',
      'placeholder' => '- Select Case -',
    ), TRUE);

    $this->addEntityRef("case[$blockId][assignee]", 'Assignee(s)', array(
      'entity' => 'Contact',
      'placeholder' => '- Select Assignee(s)-',
      'multiple' => TRUE,
      'api' => array(
        'params' => array(
          'type' => 'Individual',
        ),
      ),
    ), TRUE);
  }

  /**
   * Process the form submission.
   *
   * @param array $params
   */
  public function postProcess($params = NULL) {
    parent::postProcess($params);
  }

}
