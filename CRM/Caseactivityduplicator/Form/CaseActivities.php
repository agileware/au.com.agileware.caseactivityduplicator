<?php

use CRM_Caseactivityduplicator_ExtensionUtil as E;

/**
 * Form controller class
 *
 * @see https://wiki.civicrm.org/confluence/display/CRMDOC/QuickForm+Reference
 */
class CRM_Caseactivityduplicator_Form_CaseActivities extends CRM_Activity_Form_Activity {

  public $isRequestForBlock = FALSE;

  public function preProcess() {
    $this->supportsActivitySeparation = FALSE;
    parent::preProcess();
  }

  private function getSubmittedValues() {
    $values = $this->controller->exportValues($this->_name);
    if (isset($_POST['cases'])) {
      $values['cases'] = $_POST['cases'];
    }
    return $values;
  }

  /**
   * Global form rule.
   *
   * @param array $fields
   *   The input form values.
   * @param array $files
   *   The uploaded files if any.
   * @param $self
   *
   * @return bool|array
   *   true if no errors, else array of errors
   */
  public static function formRule($fields, $files, $self) {
    $cases = $fields['cases'];
    $errors = parent::formRule($fields, $files, $self);

    foreach ($cases as $blockIndex => $case) {
      if ($case['case_id'] == '') {
        $errors["cases[" . $blockIndex . "][case_id]"] = "Please select case.";
      }

      if ($case['assignee'] == '') {
        $errors["cases[" . $blockIndex . "][assignee]"] = "Please select assignee(s).";
      }
    }

    return $errors;
  }

  /**
   * Set default values for the form.
   */
  public function setDefaultValues() {
    return parent::setDefaultValues();
  }

  public function buildQuickForm() {
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
      $this->add('hidden', 'case_blocks', 1);
      $this->assign('addBlock', FALSE);
      $this->addElement('checkbox', 'with_client', ts('With Client'));

      $numBlocks = 1;
      $caseBlocks = 1;
      $values = $this->getSubmittedValues();
      $caseNumBlocks = array();

      if (isset($values['case_blocks'])) {
        $caseBlocks = $values['case_blocks'];
      }
      while ($numBlocks <= $caseBlocks) {
        $this->addBlockReferences($numBlocks);
        $caseNumBlocks[] = $numBlocks;
        $numBlocks++;
      }

      $this->assign('caseNumBlocks', $caseNumBlocks);
      $this->assign('blockId', $caseBlocks);

      CRM_Utils_System::setTitle("Step 2 - Enter the Activity Details for each Activity");
      parent::buildQuickForm();
    }

    $this->addFormRule(array('CRM_Caseactivityduplicator_Form_CaseActivities', 'formRule'), $this);

    $this->addButtons(array(
      array(
        'type' => 'upload',
        'name' => ts('Generate Activities Now'),
        'isDefault' => TRUE,
      ),
      array(
        'type' => 'cancel',
        'name' => ts('Cancel'),
      ),
    ));

  }

  /**
   * Add block reference fields for given block ID.
   *
   * @param $blockId
   */
  public function addBlockReferences($blockId) {
    $this->addEntityRef("cases[$blockId][case_id]", 'Case', array(
      'entity' => 'Case',
      'placeholder' => '- Select Case -',
    ), FALSE);

    $this->addEntityRef("cases[$blockId][assignee]", 'Assignee(s)', array(
      'entity' => 'Contact',
      'placeholder' => '- Select Assignee(s)-',
      'multiple' => TRUE,
      'api' => array(
        'params' => array(
          'type' => 'Individual',
        ),
      ),
    ), FALSE);
  }

  /**
   * Process the form submission.
   *
   * @param array $params
   */
  public function postProcess($params = NULL) {
    $params = $this->getSubmittedValues();

    $params['activity_date_time'] = CRM_Utils_Date::processDate($params['activity_date_time'], $params['activity_date_time_time']);
    $params['activity_type_id'] = $this->_activityTypeId;

    // format activity custom data
    if (!empty($params['hidden_custom'])) {
      // build custom data getFields array
      $customFields = CRM_Core_BAO_CustomField::getFields('Activity', FALSE, FALSE, $this->_activityTypeId);
      $customFields = CRM_Utils_Array::crmArrayMerge($customFields,
        CRM_Core_BAO_CustomField::getFields('Activity', FALSE, FALSE,
          NULL, NULL, TRUE
        )
      );
      $params['custom'] = CRM_Core_BAO_CustomField::postProcess($params,
        $this->_activityId,
        'Activity'
      );
    }

    CRM_Core_BAO_File::formatAttachment($params,
      $params,
      'civicrm_activity'
    );

    // call begin post process, before the activity is created/updated.
    $this->beginPostProcess($params);

    foreach ($params['cases'] as $key => $case) {
      $params['case_id'] = $case['case_id'];
      $params['assignee_contact_id'] = explode(',', $case['assignee']);
      // Set the target contact id to the Case client(s)

      if (isset($params['with_client']) && $params['with_client']) {
        $clientId = civicrm_api3('Case', 'getvalue', [ 'id' => $case['case_id'], 'return' => 'contact_id' ]);
        if (isset($params['target_contact_id']) && $params['target_contact_id'] != "" && count($clientId) > 0) {
          $clientId = "," . $clientId[1];
        }
        $params['target_contact_id'] .= $clientId;
      }
      if ($params['target_contact_id'] != "") {
        $params['target_contact_id'] = explode(",", $params['target_contact_id']);
      }

      // activity create/update
      $activity = CRM_Activity_BAO_Activity::create($params);
      $vvalue[] = array('case_id' => $case['case_id'], 'actId' => $activity->id);
      // call end post process, after the activity has been created/updated.
      $this->endPostProcess($params, $activity);
    }

    foreach ($vvalue as $vkey => $vval) {
      // update existing case record if needed
      $caseParams = $params;
      $caseParams['id'] = $vval['case_id'];
      if (!empty($caseParams['case_status_id'])) {
        $caseParams['status_id'] = $caseParams['case_status_id'];
      }

      // unset params intended for activities only
      unset($caseParams['subject'], $caseParams['details'],
        $caseParams['status_id'], $caseParams['custom']
      );
      $case = CRM_Case_BAO_Case::create($caseParams);
      // create case activity record
      $caseParams = array(
        'activity_id' => $vval['actId'],
        'case_id' => $vval['case_id'],
      );
      CRM_Case_BAO_Case::processCaseActivity($caseParams);
    }

    // send copy to selected contacts.
    $mailStatus = '';
    $mailToContacts = array();

    //CRM-5695
    //check for notification settings for assignee contacts
    $selectedContacts = array('contact_check');
    $activityContacts = CRM_Activity_BAO_ActivityContact::buildOptions('record_type_id', 'validate');
    $assigneeID = CRM_Utils_Array::key('Activity Assignees', $activityContacts);
    if (Civi::settings()->get('activity_assignee_notification') && !in_array($params['activity_type_id'], Civi::settings()->get('do_not_notify_assignees_for'))) {
      $selectedContacts[] = 'assignee_contact_id';
    }

    foreach ($vvalue as $vkey => $vval) {
      foreach ($selectedContacts as $dnt => $val) {
        if (array_key_exists($val, $params) && !CRM_Utils_Array::crmIsEmptyArray($params[$val])) {
          if ($val == 'contact_check') {
            $mailStatus = ts("A copy of the activity has also been sent to selected contacts(s).");
          }
          else {
            $this->_relatedContacts = CRM_Activity_BAO_ActivityAssignment::getAssigneeNames(array($vval['actId']), TRUE, FALSE);
            $mailStatus .= ' ' . ts("A copy of the activity has also been sent to assignee contacts(s).");
          }
          //build an associative array with unique email addresses.
          foreach ($params[$val] as $key => $value) {
            if ($val == 'contact_check') {
              $id = $key;
            }
            else {
              $id = $value;
            }

            if (isset($id) && array_key_exists($id, $this->_relatedContacts) && isset($this->_relatedContacts[$id]['email'])) {
              //if email already exists in array then append with ', ' another role only otherwise add it to array.
              if ($contactDetails = CRM_Utils_Array::value($this->_relatedContacts[$id]['email'], $mailToContacts)) {
                $caseRole = CRM_Utils_Array::value('role', $this->_relatedContacts[$id]);
                $mailToContacts[$this->_relatedContacts[$id]['email']]['role'] = $contactDetails['role'] . ', ' . $caseRole;
              }
              else {
                $mailToContacts[$this->_relatedContacts[$id]['email']] = $this->_relatedContacts[$id];
              }
            }
          }
        }
      }

      $extraParams = array('case_id' => $vval['case_id'], 'client_id' => $this->_currentlyViewedContactId);
      $result = CRM_Activity_BAO_Activity::sendToAssignee($activity, $mailToContacts, $extraParams);
      if (empty($result)) {
        $mailStatus = '';
      }

      // create follow up activity if needed
      $followupStatus = '';
      if (!empty($params['followup_activity_type_id'])) {
        $followupActivity = CRM_Activity_BAO_Activity::createFollowupActivity($vval['actId'], $params);

        if ($followupActivity) {
          $caseParams = array(
            'activity_id' => $followupActivity->id,
            'case_id' => $vval['case_id'],
          );
          CRM_Case_BAO_Case::processCaseActivity($caseParams);
          $followupStatus = ts("A followup activity has been scheduled.") . '<br /><br />';
        }
      }
      $title = ts("%1 Saved", array(1 => $this->_activityTypeName));
      CRM_Core_Session::setStatus($followupStatus . $mailStatus, $title, 'success');
    }

    CRM_Core_Session::setStatus('Case Activities has been created successfully.', 'Case Activities', 'success');
    CRM_Utils_System::redirect(CRM_Utils_System::url('civicrm/caseactivityduplicator/selectactivitytype'));

  }

}
