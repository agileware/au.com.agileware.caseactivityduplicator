<?php

require_once 'caseactivityduplicator.civix.php';
use CRM_caseactivityduplicator_ExtensionUtil as E;

/**
 * Implements hook_civicrm_config().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function caseactivityduplicator_civicrm_config(&$config) {
  _caseactivityduplicator_civix_civicrm_config($config);
}

/**
 * Implements hook_civicrm_install().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function caseactivityduplicator_civicrm_install() {
  _caseactivityduplicator_civix_civicrm_install();
}

/**
 * Implements hook_civicrm_postInstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_postInstall
 */
function caseactivityduplicator_civicrm_postInstall() {
  _caseactivityduplicator_civix_civicrm_postInstall();
}

/**
 * Implements hook_civicrm_uninstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function caseactivityduplicator_civicrm_uninstall() {
  _caseactivityduplicator_civix_civicrm_uninstall();
}

/**
 * Implements hook_civicrm_enable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function caseactivityduplicator_civicrm_enable() {
  _caseactivityduplicator_civix_civicrm_enable();
}

/**
 * Implements hook_civicrm_disable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function caseactivityduplicator_civicrm_disable() {
  _caseactivityduplicator_civix_civicrm_disable();
}

/**
 * Implements hook_civicrm_upgrade().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function caseactivityduplicator_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _caseactivityduplicator_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implements hook_civicrm_entityTypes().
 *
 * Declare entity types provided by this module.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_entityTypes
 */
function caseactivityduplicator_civicrm_entityTypes(&$entityTypes) {
  _caseactivityduplicator_civix_civicrm_entityTypes($entityTypes);
}

/**
 * Implements hook_civicrm_coreResourceList().
 *
 */
function caseactivityduplicator_civicrm_coreResourceList(&$list, $region) {
  Civi::resources()->addStyleFile('au.com.agileware.caseactivityduplicator', 'css/style.css', 0, $region);
}

/**
 * Implements hook_civicrm_navigationMenu().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_navigationMenu
 *
 */
function caseactivityduplicator_civicrm_navigationMenu(&$menu) {
  $maxID = CRM_Core_DAO::singleValueQuery("SELECT max(id) FROM civicrm_navigation");
  $navId = $maxID + 1;

  $administerMenuId = CRM_Core_DAO::getFieldValue('CRM_Core_BAO_Navigation', 'Cases', 'id', 'name');
  $parentID = !empty($administerMenuId) ? $administerMenuId : NULL;

  $navigationMenu = array(
    'attributes' => array(
      'label' => 'Case Activity Duplicator',
      'name' => 'CaseActivityDuplicator',
      'url' => 'civicrm/caseactivityduplicator/selectactivitytype',
      'permission' => 'Case Activity Duplicator',
      'operator' => NULL,
      'separator' => NULL,
      'parentID' => $parentID,
      'active' => 1,
      'navID' => $navId,
    ),
  );
  if ($parentID) {
    $menu[$parentID]['child'][$navId] = $navigationMenu;
  }
  else {
    $menu[$navId] = $navigationMenu;
  }
}
